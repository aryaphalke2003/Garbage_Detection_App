import 'package:ecotags/screens/map/hamburger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HamburgerMenu displays correct items',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: HamburgerMenu()));

    // Verify that the DrawerHeader is displayed
    expect(find.text('Drawer Header'), findsOneWidget);

    // Verify that the first item is displayed
    expect(find.text('Item 1'), findsOneWidget);

    // Verify that the second item is displayed
    expect(find.text('Item 2'), findsOneWidget);
  });
}