import 'package:camera/camera.dart';
import 'package:ecotags/providers/camera/CameraProvider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CameraProvider', () {
    late CameraProvider cameraProvider;

    setUp(() {
      // Set up a CameraProvider instance with a mock CameraDescription
      final camera = CameraDescription(
        name: 'test_camera',
        lensDirection: CameraLensDirection.back,
        sensorOrientation: 0,


      );
      cameraProvider = CameraProvider(camera: camera);
    });

    test('getCamera() returns the correct camera', () {
      // Verify that the getCamera() method returns the correct CameraDescription
      expect(cameraProvider.getCamera().name, 'test_camera');
    });

    test('isCameraInitialized is false by default', () {
      // Verify that the isCameraInitialized property is false by default
      expect(cameraProvider.isCameraInitialized, false);
    });
  });
}