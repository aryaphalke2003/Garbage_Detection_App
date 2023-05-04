// import 'package:camera/camera.dart';
// import 'package:ecotags/providers/camera/CameraProvider.dart';
// import 'package:ecotags/screens/camera/camera.dart';
// import 'package:ecotags/screens/loading.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';

// class MockCameraController extends Mock implements CameraController {}

// class MockCameraProvider extends Mock implements CameraProvider {}

// void main() {
//   group('CameraWidget', () {
//     late CameraController mockController;
//     late CameraProvider mockProvider;

//     setUp(() {
//       mockController = MockCameraController();
//       mockProvider = MockCameraProvider();
//     });

//     testWidgets('should display camera preview when controller is done initializing',
//         (WidgetTester tester) async {
//       final cameraWidget = CameraWidget();

//       when(mockProvider.getCamera()).thenReturn(CameraDescription(
//         name: 'My Camera',
//         lensDirection: CameraLensDirection.back,
//         sensorOrientation: 0,
//       ));

//       // Act
//       await tester.pumpWidget(
//         MaterialApp(
//           home: ChangeNotifierProvider<CameraProvider>.value(
//             value: mockProvider,
//             child: cameraWidget,
//           ),
//         ),
//       );

//       final CameraWidgetState state = tester.state(find.byType(CameraWidget));

//       await tester.pumpAndSettle();
//       when(mockController.initialize()).thenAnswer((_) => Future.value());
//       state.initState();
//       await tester.pumpAndSettle();

//       // Assert
//       expect(find.byType(CameraPreview), findsOneWidget);
//     });

//     testWidgets('should display loading widget while controller is initializing',
//         (WidgetTester tester) async {
//       final cameraWidget = CameraWidget();
//       when(mockProvider.getCamera()).thenReturn(CameraDescription(
//         name: 'My Camera',
//         lensDirection: CameraLensDirection.back,
//         sensorOrientation: 0,
//       ));

//       // Act
//       await tester.pumpWidget(
//         MaterialApp(
//           home: ChangeNotifierProvider<CameraProvider>.value(
//             value: mockProvider,
//             child: cameraWidget,
//           ),
//         ),
//       );

//       final CameraWidgetState state = tester.state(find.byType(CameraWidget));

//       await tester.pumpAndSettle();
//       when(mockController.initialize()).thenAnswer((_) => Future.delayed(Duration(seconds: 2)));
//       state.initState();
//       await tester.pump(Duration(seconds: 1));

//       // Assert
//       expect(find.byType(LoadingWidget), findsOneWidget);
//     });
//   });
// }