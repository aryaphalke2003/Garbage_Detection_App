const app = require('./index.js');
const request = require('supertest');

// Mocking the database
const usersDb = {
  doc: jest.fn().mockReturnThis(),
  get: jest.fn(),
};

const imageDb = {
  where: jest.fn().mockReturnThis(),
  get: jest.fn(),
};

// Mocking the middleware function
const authorizeUser = jest.fn((req, res, next) => {
  req.user_id = 'test_user_id';
  next();
});



describe('PUT /updateUser', () => {
  test('responds with 200 status and "user_updated" message', async () => {
    // Mocking the update method of usersDb
    const mockUpdate = jest.fn();
    const mockUsersDb = {
      doc: () => ({ update: mockUpdate })
    };

    const res = await request(app).put('/updateUser').send({ username: 'johndoe', rank: 'admin' });

    expect(res.status).resolves.toBe(200);
    expect(res.text).resolves.toBe('user_updated');
    expect(mockUpdate).toHaveBeenCalledWith({ rank: 'admin' });
  });

  test('responds with 500 status if update throws an error', async () => {
    // Mocking the update method of usersDb to throw an error
    const mockUpdate = jest.fn(() => { throw new Error('Update error') });
    const mockUsersDb = {
      doc: () => ({ update: mockUpdate })
    };
    const res = await request(app).put('/updateUser').send({ username: 'johndoe', rank: 'admin' });

    expect(res.status).toBe(500);
    expect(res.error.text).toBe('Internal Server Error');
  });
});

describe("GET /userImages", () => {
  test("returns 200 and an array of user's images", async () => {
    const userId = "user123";
    const mockImages = [      { id: "1", data: () => ({ url: "image1.jpg", user_id: userId }) },      { id: "2", data: () => ({ url: "image2.jpg", user_id: "otherUser" }) },      { id: "3", data: () => ({ url: "image3.jpg", user_id: userId }) },    ];
    imageDb.get.mockResolvedValue(mockImages);

    const response = await request(app).get("/userImages").set("Authorization", "Bearer someToken").send({ id: userId });

    expect(response.statusCode).toBe(200);
    expect(response.body).toEqual(["image1.jpg", "image3.jpg"]);
  });

  test("returns 404 if user has no images", async () => {
    const userId = "user123";
    const mockImages = [      { id: "1", data: () => ({ url: "image1.jpg", user_id: "otherUser" }) },      { id: "2", data: () => ({ url: "image2.jpg", user_id: "anotherUser" }) },    ];
    imageDb.get.mockResolvedValue(mockImages);

    const response = await request(app).get("/userImages").set("Authorization", "Bearer someToken").send({ id: userId });

    expect(response.statusCode).toBe(404);
    expect(response.text).toBe("Some error occured");
  });

  test("returns 401 if no authorization token provided", async () => {
    const response = await request(app).get("/userImages").send({ id: "user123" });

    expect(response.statusCode).toBe(404);
    expect(response.text).toBe("Some error occured");
  });

  test("returns 400 if no user ID provided", async () => {
    const response = await request(app).get("/userImages").set("Authorization", "Bearer someToken").send({});

    expect(response.statusCode).toBe(404);
    expect(response.text).toBe("Some error occured");
  });
});
