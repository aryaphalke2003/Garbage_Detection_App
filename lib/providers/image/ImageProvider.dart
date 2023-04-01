import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ImageProvider extends ChangeNotifier {
  List<XFile> _images = [];
  List<XFile> get images => _images;
  void addImage(XFile image) {
    _images.add(image);
    notifyListeners();
  }

  void removeImage(XFile image) {
    _images.remove(image);
    notifyListeners();
  }

  void clearImages() {
    _images.clear();
    notifyListeners();
  }
}
