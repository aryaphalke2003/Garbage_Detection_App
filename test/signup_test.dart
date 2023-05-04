// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecotags/screens/signup.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// class MockFirebaseAuth extends Mock implements FirebaseAuth {}
// class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

// void main() {
//   // Declare necessary variables
//   late SignUpScreen signUpScreen;
//   late Widget testWidget;
//   late MockFirebaseAuth mockFirebaseAuth;
//   late MockFirebaseFirestore mockFirebaseFirestore;

//   // Set up mock objects and widget
//   setUp(() {
//     mockFirebaseAuth = MockFirebaseAuth();
//     mockFirebaseFirestore = MockFirebaseFirestore();
//     signUpScreen = SignUpScreen();
//     testWidget = MaterialApp(home: signUpScreen);
//   });

//   // Test the widget rendering and form validation
//   testWidgets('SignUpScreen form validation', (WidgetTester tester) async {
//     await tester.pumpWidget(testWidget);

//     // Enter invalid data into the email field
//     await tester.enterText(
//         find.byWidgetPredicate((widget) =>
//             widget is TextFormField &&
//             widget.decoration?.hintText == 'Input your email'),
//         'invalid-email');
//     await tester.tap(find.text('Sign Up'.toUpperCase()));
//     await tester.pumpAndSettle();

//     // Verify that the error message is displayed
//     expect(find.text('Please enter a valid email.'), findsOneWidget);

//     // Enter valid data into the form fields
//     await tester.enterText(
//         find.byWidgetPredicate((widget) =>
//             widget is TextFormField &&
//             widget.decoration?.hintText == 'Input your email'),
//         'hello@example.com');
//     await tester.enterText(
//         find.byWidgetPredicate(
//             (widget) => widget is TextFormField && widget.hintText == 'First Name'),
//         'John');
//     await tester.enterText(
//         find.byWidgetPredicate(
//             (widget) => widget is TextFormField && widget.hintText == 'Last Name'),
//         'Doe');
//     await tester.enterText(
//         find.byWidgetPredicate(
//             (widget) => widget is TextFormField && widget.hintText == 'Password'),
//         'password123');
//     await tester.enterText(
//         find.byWidgetPredicate(
//             (widget) => widget is TextFormField && widget.hintText == 'Confirm Password'),
//         'password123');

//     // Mock the Firebase authentication and Firestore database
//     when(mockFirebaseAuth.createUserWithEmailAndPassword(
//       email: 'hello@example.com',
//       password: 'password123',
//     )).thenAnswer((_) => Future.value(UserCredential.fromUser(User(uid: 'abc123')))));
//     when(mockFirebaseFirestore.collection('users')).thenReturn(CollectionReference(MockFirebaseFirestore(), 'users'));
//     when(mockFirebaseFirestore.collection('users').doc('abc123')).thenReturn(DocumentReference(MockFirebaseFirestore(), 'users/abc123'));

//     // Submit the form
//     await tester.tap(find.text('Sign Up'.toUpperCase()));
//     await tester.pumpAndSettle();

//     // Verify that the user is added to the Firestore database
//     verify(mockFirebaseFirestore.collection('users').doc('abc123').set({
//       'firstName': 'John',
//       'lastName': 'Doe',
//       'email': 'hello@example.com',
//       'points': 0,
//       'rank': 'rookie',
//     })).called(1);

//     // Verify that the WelcomeScreen is pushed onto the stack
//     expect(find.byType(WelcomeScreen), findsOneWidget);
//   }
// }