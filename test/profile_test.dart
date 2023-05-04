// import 'package:ecotags/providers/user/UserDetailsProvider.dart';
// import 'package:ecotags/screens/profile/Profile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:provider/provider.dart';

// void main() {
//   testWidgets('Profile widget shows user information', (WidgetTester tester) async {
//     // Create a UserDetailsProvider with sample data
//     final userDetailsProvider = UserDetailsProvider();
//     userDetailsProvider.firstName = 'John';
//     userDetailsProvider.points = 100;
//     userDetailsProvider.rank = 'Novice';
//     userDetailsProvider.pictures = [
//       Picture(image: 'https://example.com/image1.jpg', latitude: 1.0, longitude: 2.0),
//       Picture(image: 'https://example.com/image2.jpg', latitude: 3.0, longitude: 4.0),
//     ];

//     // Wrap the Profile widget with a Provider<UserDetailsProvider>
//     await tester.pumpWidget(
//       Provider<UserDetailsProvider>.value(
//         value: userDetailsProvider,
//         child: MaterialApp(
//           home: Profile(),
//         ),
//       ),
//     );

//     // Verify that the widget displays the user's information
//     expect(find.text('@John'), findsOneWidget);
//     expect(find.text('100 Points'), findsOneWidget);
//     expect(find.text('Novice'), findsOneWidget);
//     expect(find.byType(Image), findsNWidgets(2));
//   });
// }