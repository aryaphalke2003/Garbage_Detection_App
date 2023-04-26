import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart' as Path;

Future<bool> uploadImage(XFile file) async {
  // Get the current user's UID
  final User? user = FirebaseAuth.instance.currentUser;
  final uid = user?.uid;

  // Get the user's location
  final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  // Create a reference to the location you want to upload to in Firebase Storage
  final storageRef = FirebaseStorage.instance
      .ref("uploads")
      .child("$uid/${Path.basename(file.path)}");

  try {
    // Upload the image file to Firebase Storage
    final snapshot = await storageRef.putFile(File(file.path));

    // Get the download URL of the uploaded image
    final downloadUrl = await snapshot.ref.getDownloadURL();

    // Save the download URL to Firestore with the current user's UID as the document ID
    await FirebaseFirestore.instance
        .collection('images')
        .doc(uid)
        .set({'url': downloadUrl, 'latitude': position.latitude, 'longitude': position.longitude});

    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
