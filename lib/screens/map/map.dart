import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecotags/providers/MapProvider.dart';
import 'package:ecotags/screens/loading.dart';
import 'package:ecotags/services/ApiServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'maputils.dart';

class MapWidget extends StatefulWidget {
  // list of map markers
  MapWidget({
    Key? key,
  }) : super(key: key);
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Completer<GoogleMapController> _controller = Completer();

  bool _isMapLoading = false;
  List<MapObject> _mapObjects = [];

  @override
  void initState() {
    super.initState();
    // _getName();
    print("test");
    _getMapObjects().then(
      (value) => setState(() {
        _mapObjects = value;
        _isMapLoading = false;
      }),
    );
  }

  // Marker _mapObjectToMarker(MapObject mapObject) {
  //   return Marker(
  //       markerId: MarkerId(mapObject.id),
  //       position: LatLng(mapObject.latitude, mapObject.longitude),
  //       icon: getIconForMapObject(mapObject.mapObjectType),
  //       infoWindow: InfoWindow(
  //           title: 'By: ${mapObject.title}', snippet: mapObject.details));
  // }

  Marker _mapObjectToMarker(MapObject mapObject) {
    return Marker(
        markerId: MarkerId(mapObject.id),
        position: LatLng(mapObject.latitude, mapObject.longitude),
        icon: getIconForMapObject(mapObject.mapObjectType),
        infoWindow: InfoWindow(
          title: 'By: ${mapObject.title}',
          snippet:  'Click to see the ' +mapObject.details,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(mapObject.title),
                  content: Image.network(mapObject.imageurl),
                );
              },
            );
          },
        ));
  }

  // Marker _mapObjectToMarker(MapObject mapObject) {
  //   if (mapObject.mapObjectType == MapObjectTypes.imageLocation) {
  //     return Marker(
  //       markerId: MarkerId(mapObject.id),
  //       position: LatLng(mapObject.latitude, mapObject.longitude),
  //       icon: getIconForMapObject(mapObject.mapObjectType),
  //       infoWindow: InfoWindow(
  //         title: mapObject.title,
  //         snippet: mapObject.details,
  //       ),
  //     );
  //   } else {
  //     return Marker(
  //       markerId: MarkerId(mapObject.id),
  //       position: LatLng(mapObject.latitude, mapObject.longitude),
  //       icon: getIconForMapObject(mapObject.mapObjectType),
  //       infoWindow: InfoWindow(
  //         title: 'By: ${mapObject.title}',
  //         snippet: mapObject.details,
  //       ),
  //     );
  //   }
  // }

  // Set<Marker> _getMapMarkers(List<MapObject> mapObjects2) {
  //   Set<Marker> markers = Set();
  //   // iterate over map objects
  //   for (var mapObject in mapObjects2) {
  //     // add marker to markers
  //     markers.add(_mapObjectToMarker(mapObject));
  //   }
  //   return markers;
  //   // return mapObjects.map((mapObject) => _mapObjectToMarker(mapObject)).toSet();
  // }

  Set<Marker> _getMapMarkers(List<MapObject> mapObjects2) {
    Set<Marker> markers = Set();
    // iterate over map objects
    for (var mapObject in mapObjects2) {
      // add marker to markers
      markers.add(_mapObjectToMarker(mapObject));
    }
    return markers;
  }

  // restrict only to india
  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(20.5937, 78.9629),
    zoom: 5,
  );

  // take marker as class variable

  @override
  Widget build(BuildContext context) {
    if (!_isMapLoading) {
      return Consumer<MapProvider>(builder: (context, map, child) {
        return Scaffold(
            body: Stack(
          children: <Widget>[
            // remove buttons
            GoogleMap(
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                initialCameraPosition: _cameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  // controller.setMapStyle(map.mapStyle);
                },
                markers: _getMapMarkers(_mapObjects))
          ],
        ));
      });
    } else {
      return LoadingWidget(message: "Map is Loading!");
    }
  }

  // Future<List<MapObject>> _getMapObjects() async {
  //   Position currUserLocation = await _getCurrPosition();
  //   List<MapObject> locations = [
  //     MapObject(
  //       id: '1',
  //       mapObjectType: MapObjectTypes.currUserPosition,
  //       latitude: currUserLocation.latitude,
  //       longitude: currUserLocation.longitude,
  //       title: 'Test',
  //       details: 'Test',
  //     )
  //   ];

  //   // get locations
  //   // add to mapObjects

  //   ApiResponse response = await getApiCall("getLocations");
  //   for (var location in response.data) {
  //     print(location['location_type']);
  //     locations.add(
  //       MapObject(
  //         id: location['id'].toString(),
  //         mapObjectType: getMapObjectType(location['location_type']),
  //         longitude: location['longitude'],
  //         latitude: location['latitude'],
  //         title: location['username'],
  //         details: location['description'],
  //       ),
  //     );
  //   }

  //   return locations;
  // }
  Future<List<MapObject>> _getMapObjects() async {
    Position currUserLocation = await _getCurrPosition();
    List<MapObject> locations = [
      MapObject(
        id: '1',
        mapObjectType: MapObjectTypes.currUserPosition,
        latitude: currUserLocation.latitude,
        longitude: currUserLocation.longitude,
        title: 'Test',
        details: 'Test', 
        imageurl: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fimages%2Fsearch%2Fnature%2F&psig=AOvVaw0tGasV8WyxixbiRdFblGKr&ust=1682708677654000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCLjL2Lrgyv4CFQAAAAAdAAAAABAE',
      )
    ];

    final QuerySnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    for (QueryDocumentSnapshot userDoc in userSnapshot.docs) {
      String userId = userDoc.id;

      final QuerySnapshot imageSnapshot = await FirebaseFirestore.instance
          .collection('images')
          .doc(userId)
          .collection('user_images')
          .get();

      for (QueryDocumentSnapshot imageDoc in imageSnapshot.docs) {
        Map<String, dynamic>? data = imageDoc.data() as Map<String, dynamic>?;
        print('fck');
        print(data);
        locations.add(
          MapObject(
            id: imageDoc.id,
            mapObjectType: MapObjectTypes.imageLocation,
            latitude: data!['latitude'],
            longitude: data['longitude'],
            title: 'img',
            details: 'img', 
            imageurl: data['url'],
          ),
        );
      }
    }

    return locations;
  }

  Future<Position> _getCurrPosition() async {
    // get current position
    // add to mapObjects
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
}
