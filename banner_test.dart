// import 'package:ecotags/screens/social/banner.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   testWidgets('BannerViewer widget displays heading and icons',
//       (WidgetTester tester) async {
//     // Define the test data
//     const heading = 'Test Heading';
//     const icon1 = 'assets/user.jpg';
//     const icon2 = 'assets/user.jpg';
//     const icon3 = 'assets/user.jpg';

//     // Build the widget tree
//     await tester.pumpWidget(MaterialApp(
//       home: BannerViewer(
//         heading: heading,
//         icon1: icon1,
//         icon2: icon2,
//         icon3: icon3,
//       ),
//     ));

//     // Verify that the widget displays the correct heading and icons
//     expect(find.text(heading), findsOneWidget);
//     expect(find.byType(Image), findsNWidgets(3));
//     expect(
//         find.byWidgetPredicate(
//             (widget) => widget is Image && widget.image == AssetImage(icon1)),
//         findsOneWidget);
//     expect(
//         find.byWidgetPredicate(
//             (widget) => widget is Image && widget.image == AssetImage(icon2)),
//         findsOneWidget);
//     expect(
//         find.byWidgetPredicate(
//             (widget) => widget is Image && widget.image == AssetImage(icon3)),
//         findsOneWidget);
//   });
// }
