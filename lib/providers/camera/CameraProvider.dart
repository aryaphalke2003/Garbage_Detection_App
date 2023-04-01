import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CameraProvider extends ChangeNotifier {
  late CameraDescription _camera;
  CameraDescription get camera => _camera;

  // constructor
  CameraProvider({required CameraDescription camera}) {
    print("CameraProvider constructor called");
    _camera = camera;
  }

  bool isCameraInitialized = false;

  // factory method for getting camera
  CameraDescription getCamera() {
    // if camera is not initialized then initialize it
    return _camera;
  }
}
