import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapObject {
  // map object id
  final String id;

  // map objects enum
  final MapObjectTypes mapObjectType;
  // map object position
  final double latitude;
  final double longitude;
  // map object title
  final String title;
  // map object details
  final String details;

  MapObject({
    required this.id,
    required this.mapObjectType,
    required this.latitude,
    required this.longitude,
    required this.title,
    required this.details,
  });
}

// enum of map objects
enum MapObjectTypes {
  // user position
  currUserPosition,
  userPosition,
  nonUserPosition,
}

// get icon for map object
BitmapDescriptor getIconForMapObject(MapObjectTypes mapObjectType) {
  switch (mapObjectType) {
    case MapObjectTypes.currUserPosition:
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    case MapObjectTypes.userPosition:
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);

    case MapObjectTypes.nonUserPosition:
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  }
}

MapObjectTypes getMapObjectType(dynamic type) {
  if (type == "SELF") {
    return MapObjectTypes.userPosition;
  } else if (type == "OTHER") {
    return MapObjectTypes.nonUserPosition;
  } else {
    return MapObjectTypes.currUserPosition;
  }
}
