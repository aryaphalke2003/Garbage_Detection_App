import 'package:ecotags/screens/map/maputils.dart';
import 'package:test/test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  group('MapObject', () {
    test('should create a MapObject instance', () {
      final mapObject = MapObject(
        id: '1',
        mapObjectType: MapObjectTypes.userPosition,
        latitude: 37.4219999,
        longitude: -122.0840575,
        title: 'Googleplex',
        details: 'Google HQ',
        imageurl: 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png',
      );

      expect(mapObject.id, '1');
      expect(mapObject.mapObjectType, MapObjectTypes.userPosition);
      expect(mapObject.latitude, 37.4219999);
      expect(mapObject.longitude, -122.0840575);
      expect(mapObject.title, 'Googleplex');
      expect(mapObject.details, 'Google HQ');
      expect(mapObject.imageurl, 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png');
    });
  });

  group('getIconForMapObject', () {
    test('should return a BitmapDescriptor', () {
      final icon = getIconForMapObject(MapObjectTypes.userPosition);

      expect(icon, isA<BitmapDescriptor>());
    });
  });

  group('getMapObjectType', () {
    test('should return MapObjectTypes.userPosition for "SELF"', () {
      final type = getMapObjectType('SELF');

      expect(type, MapObjectTypes.userPosition);
    });

    test('should return MapObjectTypes.nonUserPosition for "OTHER"', () {
      final type = getMapObjectType('OTHER');

      expect(type, MapObjectTypes.nonUserPosition);
    });

    test('should return MapObjectTypes.currUserPosition for any other value', () {
      final type = getMapObjectType('UNKNOWN');

      expect(type, MapObjectTypes.currUserPosition);
    });
  });
}