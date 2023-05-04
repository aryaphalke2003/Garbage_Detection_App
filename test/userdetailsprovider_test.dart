import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecotags/providers/user/UserDetailsProvider.dart';
import 'package:ecotags/screens/profile/PhotoGallery.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockDocumentReference extends Mock implements DocumentReference {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

class MockQuerySnapshot extends Mock implements QuerySnapshot {}

class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot {
  MockQueryDocumentSnapshot(this._data, {required Map<String, Object> data});
  final Map<String, dynamic> _data;

  @override
  Map<String, dynamic> data() => _data;
}
class MockQuery extends Mock implements Query {}

void main() {
  group('UserDetailsProvider', () {
    late UserDetailsProvider provider;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockFirebaseFirestore mockFirebaseFirestore;
    late MockCollectionReference mockCollectionReference;
    late MockDocumentReference mockDocumentReference;

    setUpAll(() async {
      // Initialize Firebase for the test environment
      await Firebase.initializeApp();
    });

    setUp(() {
      // Set up mocks for FirebaseAuth, FirebaseFirestore, and CollectionReference
      mockFirebaseAuth = MockFirebaseAuth();
      mockFirebaseFirestore = MockFirebaseFirestore();
      mockCollectionReference = MockCollectionReference();
      mockDocumentReference = MockDocumentReference();

      // Set up a UserDetailsProvider instance with a mock Firebase user and user details
      when(mockFirebaseAuth.currentUser).thenReturn(MockUser());
      when(mockFirebaseFirestore.collection(any)).thenReturn(mockCollectionReference as CollectionReference<Map<String, dynamic>>);
      when(mockFirebaseFirestore.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => MockDocumentSnapshot());
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockCollectionReference.get()).thenAnswer((_) async => MockQuerySnapshot());
      when(mockQuerySnapshot.docs).thenReturn([]);
      provider = UserDetailsProvider();
    });

    test('loadUserDetails() sets the user details', () async {
      // Verify that loadUserDetails() sets the user details correctly
      final mockSnapshot = MockDocumentSnapshot();
      when(mockSnapshot.data()).thenReturn({
        'firstName': 'John',
        'lastName': 'Doe',
        'email': 'johndoe@example.com',
        'rank': 'ROOKIE',
        'points': 100,
      });
      when(mockDocumentReference.get()).thenAnswer((_) async => mockSnapshot);
      await provider._loadUserDetails();
      expect(provider.firstName, 'John');
      expect(provider.lastName, 'Doe');
      expect(provider.email, 'johndoe@example.com');
      expect(provider.rank, 'ROOKIE');
      expect(provider.points, 100);
    });

    test('loadUserDetails() sets the user pictures', () async {
      // Verify that loadUserDetails() sets the user pictures correctly
      final mockSnapshot = MockQuerySnapshot();
      when(mockQuerySnapshot.docs).thenReturn([
        MockQueryDocumentSnapshot(data: {'url': 'https://example.com/picture1', 'id': 'picture1', 'latitude': 0.0, 'longitude': 0.0}),
        MockQueryDocumentSnapshot(data: {'url': 'https://example.com/picture2', 'id': 'picture2', 'latitude': 1.0, 'longitude': 1.0}),
      ]);
      when(mockCollectionReference.get()).thenAnswer((_) async => mockSnapshot);
      await provider._loadUserDetails();
      expect(provider.pictures.length, 2);
      expect(provider.pictures[0].url, 'https://example.com/picture1');
      expect(provider.pictures[0].id, 'picture1');
      expect(provider.pictures[0].latitude, 0.0);
      expect(provider.pictures[0].longitude, 0.0);
      expect(provider.pictures[1].url, 'https://example.com/picture2');
      expect(provider.pictures[1].id, 'picture2');
      expect(provider.pictures[1].latitude, 1.0);
      expect(provider.pictures[1].longitude, 1.0);
    });

    test('updateName() updates the user name', () async {
      // Verify that updateName() updates the user name correctly
      await provider.updateName('Jane', 'Doe');
      expect(provider.firstName, 'Jane');
      expect(provider.lastName, 'Doe');
    });

    test('updateRank() updates the user rank', () async {
      // Verify that updateRank() updates the user rank correctly
      await provider.updateRank('MODERATOR');
      expect(provider.rank, 'MODERATOR');
    });

    test('updatePoints() updates the user points', () async {
      // Verify that updatePoints() updates the user points correctly
      await provider.updatePoints(200);
      expect(provider.points, 200);
    });

    test('deletePicture() deletes the user picture', () async {
      // Verify that deletePicture() deletes the user picture correctly
      final mockPicture = Picture('https://example.com/picture1', 'picture1', 0.0, 0.0);
      when(mockDocumentReference.delete()).thenAnswer((_) async => null);
      when(mockFirebaseAuth.currentUser).thenReturn(MockUser(uid: 'user1'));
      await provider.deletePicture(mockPicture.id);
      verify(mockFirebaseFirestore.collection('images').doc('user1').collection('user_images').doc('picture1').delete());
      verify(mockFirebaseStorage.ref('uploads/user1/picture1.jpg').delete());
      expect(provider.pictures.length, 0);
    });
  });
}

// Mock classes for FirebaseAuth and FirebaseUser
class MockUser extends Mock implements User {
  final String uid;

  MockUser({this.uid = 'user1'});
}