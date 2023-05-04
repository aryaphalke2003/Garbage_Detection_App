import 'package:ecotags/providers/MapProvider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MapProvider', () {
    test('constructor should set mapStyle property', () {
      // Arrange
      const expectedStyle = 'dark';
      
      // Act
      final mapProvider = MapProvider(mapStyle: expectedStyle);
      
      // Assert
      expect(mapProvider.mapStyle, equals(expectedStyle));
    });
  });
}