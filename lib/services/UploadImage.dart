import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecotags/screens/map/maputils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart' as Path;
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
// import 'package:geodesy/geodesy.dart';

final double uploadRadius = 100.0; // Radius in meters

//first check if the image can be uploaded or not

// Future<bool> imageuploadcheck() async {
//   Position position = await Geolocator.getCurrentPosition();
//   LatLng currentLocation = LatLng(position.latitude, position.longitude);

//   bool canUpload = true;
//   List<LatLng> existingUploadLocations =
//       []; // Replace with existing upload locations

//   final QuerySnapshot userSnapshot =
//       await FirebaseFirestore.instance.collection('users').get();

//   for (QueryDocumentSnapshot userDoc in userSnapshot.docs) {
//     String userId = userDoc.id;

//     final QuerySnapshot imageSnapshot = await FirebaseFirestore.instance
//         .collection('images')
//         .doc(userId)
//         .collection('user_images')
//         .get();

//     for (QueryDocumentSnapshot imageDoc in imageSnapshot.docs) {
//       Map<String, dynamic>? data = imageDoc.data() as Map<String, dynamic>?;
 
//       print(data);

//       existingUploadLocations.add(LatLng(data!['latitude'], data['longitude']));
//     }

//     for (LatLng existingLocation in existingUploadLocations) {
//       // // // Geodesy geodesy = Geodesy();
//       // double distance = geodesy
//           .distanceBetweenTwoGeoPoints(currentLocation, existingLocation)
//           .toDouble();

//       if (distance <= uploadRadius) {
//         canUpload = false;
//         break;
//       }
//     }
//   }
//   return canUpload;
// }

Future<String> uploadImage(XFile file) async {


  //  bool canUpload = await imageuploadcheck();
  bool canUpload = true;
   if(canUpload == false){
     return 'nospace';
   }
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
    print("/////////////////////////////////////////////////////////////////");

    ////call the api and set the level of garbage and store the data with the image
    int message = 0;
    try {
      final String apiUrl = "https://was-det.onrender.com/predict";
      final Map<String, dynamic> requestData = {"url": downloadUrl};

      final response = await http.post(Uri.parse(apiUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(requestData));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData);
        message = responseData["message"] as int;
      } else {
        message = -1;
      }
    } catch (e) {
      message = -1;
    }

    print(message);
    print("\n\n\n\n");
    print(downloadUrl);

    // Save the download URL to Firestore with the current user's UID as the document ID
    await FirebaseFirestore.instance
        .collection('images')
        .doc(uid)
        .collection(
            'user_images') // use a collection name that represents the user's images
        .doc(DateTime.now()
            .toString()) // use DateTime.now().toString() to get the current timestamp as a string
        .set({
      'url': downloadUrl,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'extent': message
    });

    return 'done';
  } catch (e) {
    print(e);
    return 'error';
  }
}
