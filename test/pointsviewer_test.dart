// import 'package:ecotags/providers/user/UserDetailsProvider.dart';
// import 'package:ecotags/screens/home/pointsviewer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:provider/provider.dart';

// void main() {
//   testWidgets('PointsViewer displays correct points',
//       (WidgetTester tester) async {
//     final int points = 100;

//     await tester.pumpWidget(
//       ChangeNotifierProvider<UserDetailsProvider>(
//         create: (_) => UserDetailsProvider(),
//         child: MaterialApp(
//           home: Scaffold(
//             body: PointsViewer(
//               points: points,
//             ),
//           ),
//         ),
//       ),
//     );

//     // Set the user points to the test value
//     final userDetails = Provider.of<UserDetailsProvider>(tester.firstElement(find.byType(PointsViewer)), listen: false);
//     userDetails.setPoints(points);

//     expect(find.text('Points'), findsOneWidget);
//     expect(find.text('$points'), findsOneWidget);
//   });
// }