// make a circular loading page

import 'package:ecotags/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecotags/screens/loading.dart';

void main() {
  testWidgets('LoadingWidget displays a circular progress indicator and a message', (WidgetTester tester) async {
    // Build the widget tree.
    await tester.pumpWidget(const MaterialApp(
      home: LoadingWidget(message: 'Loading...'),
    ));

    // Expect to find a circular progress indicator and a message widget.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Loading...'), findsOneWidget);
  });
}