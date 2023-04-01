import 'package:camera/camera.dart';
import 'package:ecotags/providers/user/UserDetailsProvider.dart';
import 'package:ecotags/screens/camera/camera.dart';
import 'package:ecotags/screens/loading.dart';
import 'package:ecotags/screens/map/hamburger.dart';
import 'package:ecotags/screens/map/map.dart';
import 'package:ecotags/screens/map/maputils.dart';
import 'package:ecotags/screens/profile/Profile.dart';
import 'package:ecotags/services/ApiServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'bottomnav.dart';
import 'home/climateparametersviewer.dart';
import 'home/pointsviewer.dart';

class HomeScreen extends StatefulWidget {
  static String tag = 'login-page';
  // final CameraDescription camera;
  const HomeScreen({
    super.key,
    // required this.camera,
  });
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isLoading = true;
  int _currIndex = 2;
  String _name = 'World';
  List<MapObject> _mapObjects = [
    MapObject(
      id: '1',
      mapObjectType: MapObjectTypes.currUserPosition,
      latitude: 0.0,
      longitude: 0.0,
      title: 'Test',
      details: 'Test',
    ),
  ];

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  // define a funciton to convert MapObject to Marker

  @override
  void initState() {
    super.initState();
    _getUserDetails().then((value) => setState(() {
          // set in Provider
          Provider.of<UserDetailsProvider>(context, listen: false)
              .setUserDetails(value);

          isLoading = false;
        }));
    // _getName();
    // _getMapObjects();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: add bottom nav
    return Scaffold(
        key: _scaffoldState,
        drawer: const HamburgerMenu(),
        bottomNavigationBar: buildBottomNav(
          (index) {
            setState(() {
              _currIndex = index;
            });
          },
        ),
        body: Stack(children: <Widget>[
          if (isLoading == 0) ...[
            LoadingWidget(message: "Loading Ecotags...")
          ] else if (_currIndex == 0) ...[
            Center(child: Text('Search'))
          ] else if (_currIndex == 1) ...[
            CameraWidget()
          ] else if (_currIndex == 2) ...[
            MapWidget()
          ] else if (_currIndex == 3) ...[
            Profile()
          ],
          if (_currIndex == 2) ...[
            Positioned(
                left: 10,
                top: 40,
                child: Container(
                  width: 45,
                  height: 45,
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  // put child at center

                  child: IconButton(
                      iconSize: 30,
                      icon: const Icon(CupertinoIcons.list_dash),
                      // onPressed: () => Scaffold.of(context).openDrawer()),
                      onPressed: () =>
                          _scaffoldState.currentState!.openDrawer()),
                )),
            Positioned(bottom: 10, right: 10, child: PointsViewer(points: 276)),
            Positioned(
                bottom: 10,
                left: 10,
                child: ClimateParametersViewer(aqi: 118, temperature: 16))
          ]
        ]));
  }

  Future<Object> _getUserDetails() async {
    // make a getApiCall to get user details
    // return the user details
    ApiResponse response = await getApiCall("getUser");
    return response.data;
  }
}
