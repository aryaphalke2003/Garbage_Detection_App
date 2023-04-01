import 'dart:io';

import 'package:ecotags/services/ApiServices.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as Path;
import 'package:camera/camera.dart';

String serverURL = 'http://localhost:5000';

getURI(String path) {
  return Uri.parse("$serverURL/$path");
}

uploadImage(XFile file) async {
  // get firebase usesr

  // Create a storage reference from our app
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  File fileObject = File(file.path);
  if (fileObject == null) {
    return;
  }

  // Create a reference to the location you want to upload to in firebase
  final storageRef = FirebaseStorage.instance
      .ref("uploads")
      .child(Path.basename(fileObject.path));
  try {
    TaskSnapshot snapshot = await storageRef.putFile(fileObject);
    // get the download url
    String downloadURL = await snapshot.ref.getDownloadURL();

    await postApiCall({
      "url": downloadURL,
      "latitude": position.latitude,
      "longitude": position.longitude,
    }, "addImage");
    // upload the download url to firestore

    return true;
  } catch (e) {
    return false;
  }
}
