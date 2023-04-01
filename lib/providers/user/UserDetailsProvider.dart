import 'package:ecotags/screens/profile/PhotoGallery.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum UserLevel {
  ROOKIE,
  MODERATOR,
  ADMIN,
}

class UserDetailsProvider extends ChangeNotifier {
  User user = FirebaseAuth.instance.currentUser!;

  int _age = 0;
  String _userName = 'aneeMangal';
  UserLevel _userLevel = UserLevel.ROOKIE;
  String _pfpUrl =
      'https://firebasestorage.googleapis.com/v0/b/ecotags.appspot.com/o/uploads%2Faneeket.png?alt=media&token=480414e7-4c1a-47f5-8c98-014527dee222';

  int _points = 120;
  List<Picture> _pictures = [
    Picture(
        "https://images.pexels.com/photos/1772973/pexels-photo-1772973.png?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Stephan Seeber"),
    Picture(
        "https://images.pexels.com/photos/1758531/pexels-photo-1758531.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Liam Gant"),
  ];
  String get pfpUrl => _pfpUrl;
  List<Picture> get pictures => _pictures;
  int get userAge => _age;
  String get userName => _userName;

  String _fullName = 'Aneeket Mangal';
  String get fullName => _fullName;

  String get userLevel => 'Rookie';

  int get points => _points;
  void updateAge(int age) {
    _age = age;
    notifyListeners();
  }

  isAuthenticated() {
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  void getUserName() {
    _userName = user.displayName!;
    notifyListeners();
  }

  void updateName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setUserDetails(dynamic details) {
    _fullName = details['first_name'] + ' ' + details['last_name'];
    _age = details['age'];
    _userName = details['username'];

    // _pfpUrl = details['pfpUrl'];
    _points = details['points'];
    if (details.containsKey('pictures')) {
      for (var picture in details['pictures']) {
        _pictures.add(Picture(picture['url'], picture['id']));
      }
    }

    notifyListeners();
  }
}
