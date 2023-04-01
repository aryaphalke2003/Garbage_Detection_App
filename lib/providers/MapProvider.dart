import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MapProvider extends ChangeNotifier {
  late String _mapStyle;
  String get mapStyle => _mapStyle;

  // constructor
  MapProvider({required String mapStyle}) {
    print("CameraProvider constructor called");
    _mapStyle = mapStyle;
  }
}
