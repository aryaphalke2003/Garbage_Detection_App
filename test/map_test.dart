// import 'package:ecotags/providers/MapProvider.dart';
// import 'package:ecotags/screens/map/map.dart';
// import 'package:ecotags/screens/map/maputils.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// class MockMapObject extends Mock implements MapObject {}

// void main() {
//   group('MapWidget', () {
//     testWidgets('should display loading widget when map is loading',
//         (WidgetTester tester) async {
//       //Arrange
//       final mapProvider = MapProvider();
//       final mapWidget = MapWidget();
//       mapWidget._isMapLoading = true;

//       //Act
//       await tester.pumpWidget(mapProvider + mapWidget);

//       //Assert
//       expect(find.byType(LoadingWidget), findsOneWidget);
//     });

//     testWidgets(
//         'should display google map widget with markers when map is loaded',
//         (WidgetTester tester) async {
//       //Arrange
//       final mapProvider = MapProvider();
//       final mapWidget = MapWidget();
//       final mockMapObject = MockMapObject();
//       mapWidget._isMapLoading = false;
//       mapWidget._mapObjects = [mockMapObject];
//       final marker = Marker(markerId: MarkerId(mockMapObject.id));

//       //Act
//       await tester.pumpWidget(mapProvider + mapWidget);

//       //Assert
//       expect(find.byType(GoogleMap), findsOneWidget);
//       expect(mapWidget._getMapMarkers([mockMapObject]), contains(marker));
//     });
//   });
// }