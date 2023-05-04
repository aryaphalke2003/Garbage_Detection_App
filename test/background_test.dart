import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecotags/screens/background.dart';
import 'package:ecotags/providers/image/ImageProvider.dart';


void main() {
  testWidgets('BackgroundScreen should display an image', (WidgetTester tester) async {
    // Build the widget tree.
    await tester.pumpWidget(const MaterialApp(
      home: BackgroundScreen(),
    ));

    // Expect to find an image with the given asset path.
     expect(find.byWidgetPredicate((widget) {
      if (widget is! DecoratedBox) return false;
      final decoration = widget.decoration as BoxDecoration;
      if (decoration.image is! DecorationImage) return false;
      final imageProvider = decoration.image!.image;
      if (imageProvider is! AssetImage) return false;
      final assetImage = imageProvider as AssetImage;
      return assetImage.assetName == 'assets/logo.png';
    }), findsOneWidget);
  });
}
