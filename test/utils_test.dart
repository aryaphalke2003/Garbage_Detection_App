import 'package:ecotags/screens/camera/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should display a container', (WidgetTester tester) async {
    // Arrange
    final cameraButton = CameraButton();

    // Act
    await tester.pumpWidget(cameraButton);

    // Assert
    expect(find.byType(Container), findsOneWidget);
  });
}