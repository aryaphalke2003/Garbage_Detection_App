// import 'package:ecotags/screens/home.dart';
// import 'package:ecotags/screens/login.dart';
// import 'package:ecotags/screens/signup.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// void main() {
//   group('LoginBottomScreen widget', () {
//     final emailField = find.widgetWithText(TextFormField, 'EMAIL');
//     final passwordField = find.widgetWithText(TextField, 'PASSWORD');
//     final loginButton = find.widgetWithText(ElevatedButton, 'Login');
//     final registerButton = find.widgetWithText(Text, 'Register');

//     testWidgets('should display email and password fields',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(MaterialApp(
//         home: LoginBottomScreen(),
//       ));

//       expect(emailField, findsOneWidget);
//       expect(passwordField, findsOneWidget);
//     });

//     testWidgets('should display login button', (WidgetTester tester) async {
//       await tester.pumpWidget(MaterialApp(
//         home: LoginBottomScreen(),
//       ));

//       expect(loginButton, findsOneWidget);
//     });

//     testWidgets('should display register button', (WidgetTester tester) async {
//       await tester.pumpWidget(MaterialApp(
//         home: LoginBottomScreen(),
//       ));

//       expect(registerButton, findsOneWidget);
//     });

//     testWidgets('should navigate to home screen on successful login',
//         (WidgetTester tester) async {
//       // Mock FirebaseAuth to return a user on signInWithEmailAndPassword call
//       final mockAuth = MockFirebaseAuth();
//       when(mockAuth.signInWithEmailAndPassword(
//               email: anyNamed('email'), password: anyNamed('password')))
//           .thenAnswer((_) async => UserCredential(
//                 providerId: 'firebase',
//                 signInMethod: 'emailAndPassword',
//                 user: User(
//                   uid: 'user123',
//                   email: 'user@example.com',
//                   displayName: 'Test User',
//                 ),
//               ));

//       // Build the widget tree
//       await tester.pumpWidget(MaterialApp(
//         home: LoginBottomScreen(),
//       ));

//       // Enter email and password
//       await tester.enterText(emailField, 'test@example.com');
//       await tester.enterText(passwordField, 'password');

//       // Tap the login button
//       await tester.tap(loginButton);
//       await tester.pumpAndSettle();

//       // Verify that the home screen is displayed
//       expect(find.byType(HomeScreen), findsOneWidget);
//     });

//     testWidgets('should navigate to sign up screen on register button press',
//         (WidgetTester tester) async {
//       // Build the widget tree
//       await tester.pumpWidget(MaterialApp(
//         home: LoginBottomScreen(),
//       ));

//       // Tap the register button
//       await tester.tap(registerButton);
//       await tester.pumpAndSettle();

//       // Verify that the sign up screen is displayed
//       expect(find.byType(SignUpScreen), findsOneWidget);
//     });
//   });
// }

// class MockFirebaseAuth extends Mock implements FirebaseAuth {}
