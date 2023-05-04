import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecotags/screens/profile/PhotoGallery.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

enum UserLevel {
  ROOKIE,
  MODERATOR,
  ADMIN,
}

class UserDetailsProvider extends ChangeNotifier {
  final User user = FirebaseAuth.instance.currentUser!;
  late String _fullName;
  late String _firstName;
  late String _lastName;
  late String _email;
  late String _rank;
  late int _points;
  int _age = 20;
  String _pfpUrl =
      'https://firebasestorage.googleapis.com/v0/b/cs305-ecotags.appspot.com/o/uploads%2FCAP1366030539152407173.jpg?alt=media&token=dd285df3-8a1b-42c1-8411-11f3b3371384';

  List<Picture> _pictures = [
    // Picture(
    //     "https://images.pexels.com/photos/1772973/pexels-photo-1772973.png?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    //     "Stephan Seeber"),
    // Picture(
    //     "https://images.pexels.com/photos/1758531/pexels-photo-1758531.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    //     "Liam Gant"),
    
  ];

  String get pfpUrl => _pfpUrl;
  int get userAge => _age;
  List<Picture> get pictures => _pictures;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get rank => _rank;
  int get points => _points;

  UserDetailsProvider() {
    _loadUserDetails();
  }

  void _loadUserDetails() async {
    final picturesSnapshot = await FirebaseFirestore.instance
    .collection('images')
    .doc(user.uid)
    .collection('user_images')
    .get();

_pictures = picturesSnapshot.docs
    .map((doc) => Picture(doc['url'], doc.id , doc['latitude'],doc['longitude']))
    .toList();

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    final data = snapshot.data()!;
    _firstName = data['firstName'];
    _lastName = data['lastName'];
    _email = data['email'];
    _rank = data['rank'];
    _points = data['points'];
    notifyListeners();
  }

  isAuthenticated() {
    return user != null;
  }

  void updateName(String firstName, String lastName) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'firstName': firstName,
      'lastName': lastName,
    });
    _firstName = firstName;
    _lastName = lastName;
    notifyListeners();
  }

  void updateRank(String rank) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({'rank': rank});
    _rank = rank;
    notifyListeners();
  }

  void updatePoints(int points) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({'points': points});
    _points = points;
    notifyListeners();
  }
  void setPoints(int points) {
  _points = points;
  notifyListeners();
}

  // void setUserDetails(dynamic details) {
  //   _fullName = details['firstName'] + ' ' + details['lastName'];
  //   _age = details['age'];
  //   _firstName = details['firstName'];

  //   // _pfpUrl = details['pfpUrl'];
  //   //cheking 
  //   _points = details['points'];
  //   if (details.containsKey('pictures')) {
  //     for (var picture in details['pictures']) {
  //       _pictures.add(Picture(picture['url'], picture['id'],picture['latitude'],picture['longitude']));
  //     }
  //   }
  // }

  Future<void> deletePicture(String pictureId) async {
    await FirebaseFirestore.instance
        .collection('images')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('user_images')
        .doc(pictureId)
        .delete();

    // Delete the image file from Firebase Storage
    await FirebaseStorage.instance
        .ref('uploads/${FirebaseAuth.instance.currentUser!.uid}/$pictureId.jpg')
        .delete();
  }



  
}