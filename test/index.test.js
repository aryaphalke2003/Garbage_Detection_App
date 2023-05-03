
const request = require('supertest');
const app = require('../server/index');
const firebase = require('@firebase/testing');

// Define the Firestore emulator settings
const PROJECT_ID = 'cs305-ecotags';
const COVERAGE_URL = `http://localhost:8080/emulator/v1/projects/${PROJECT_ID}:ruleCoverage.html`;

// Define the Firestore emulator rules
const firestoreRules = `
  rules_version = '2';
  service cloud.firestore {
    match /databases/{database}/documents {
      match /users/{userId} {
        allow read, write: if request.auth.uid == userId;
      }
      match /images/{imageId} {
        allow read, write: if request.auth.uid == resource.data.userId;
      }
    }
  }
`;

// Set up the Firestore emulator
beforeAll(async () => {
    // Start the Firestore emulator
    await firebase.loadFirestoreRules({
        projectId: PROJECT_ID,
        rules: firestoreRules,
    });

    // Initialize the Firestore client with the emulator settings
    const app = firebase.initializeTestApp({
        projectId: PROJECT_ID,
        auth: { uid: 'testuser123' },
    });
    const firestore = app.firestore();
    firestore.settings({ host: 'localhost:8080', ssl: false });

    // Seed some initial data into Firestore
    const testUserRef = firestore.collection('users').doc('testuser123');
    await testUserRef.set({
        email: 'testuser@example.com',
        username: 'testuser',
        firstName: 'Test',
        lastName: 'User',
        age: 25,
        rank: 'rookie',
    });

    // Set the authentication token for the test user
    const token = await app.auth().currentUser.getIdToken();
    process.env.FIREBASE_AUTH_TOKEN = token;
});

// Close the Firestore emulator after all tests have run
afterAll(async () => {
    await Promise.all(firebase.apps().map((app) => app.delete()));
    console.log(`View rule coverage information at ${COVERAGE_URL}`);
});

describe('Test the endpoints of the app', () => {
    let testUser = {
        email: 'testuser@example.com',
        username: 'testuser',
        first_name: 'Test',
        last_name: 'User',
        age: 25,
        rank: 'user',
        id: 'testuser123',
    };


    let testImage = {
        url: 'https://images.pexels.com/photos/572487/pexels-photo-572487.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        latitude: 37.7749,
        longitude: -122.4194,
        geotagLat: 37.7749,
        geotagLong: -122.4194,
        rank: 'user',
        username: 'testuser',
    };

    let token = '';




    // Test adding a new image to the database
    // Test adding a new image to the database
    it('should add a new image to the database', async () => {
        const res = await request(app)
          .post('/addImage')
          .set('Authorization', `Bearer ${token}`)
          .send(testImage);
      
        expect(res.status).toBe(201);
        expect(res.body).toHaveProperty('success', true);
        expect(res.body).toHaveProperty('message', 'Image added successfully');
      
        // Get the added image from the Firestore emulator
        const firestore = firebase.firestore();
        firestore.settings({ host: 'localhost:8080', ssl: false });
        const addedImage = await firestore
          .collection('images')
          .doc(res.body.imageId)
          .get();
      
        expect(addedImage.exists).toBe(true);
        expect(addedImage.data()).toMatchObject({
          url: testImage.url,
          latitude: testImage.latitude,
          longitude: testImage.longitude,
          geotagLat: testImage.geotagLat,
          geotagLong: testImage.geotagLong,
          rank: testImage.rank,
          username: testUser.username,
          userId: testUser.id,
        });
      });


});




