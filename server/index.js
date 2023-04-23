require("dotenv").config();
const express = require("express");
const app = express();
const PORT = process.env.PORT || 5000;
const fs = require("firebase-admin");
const { v4: uuidv4 } = require("uuid");
const serviceAccount = require("./cs305-ecotags-firebase-adminsdk-89k2k-2640043c53.json");
const { pfp } = require("./pfp.js");
const { authorizeUser } = require("./middleware.js");
const { auth } = require("firebase-admin");

app.use(express.json());

fs.initializeApp({
  credential: fs.credential.cert(serviceAccount),
});
const db = fs.firestore();
const usersDb = db.collection("users");
const imageDb = db.collection("images");

// // // ----------cron job of sending regular get requests to the server so that render does not sleep!-----------//
// //
// // const cron = require("node-cron");
// //
// // const link_to_site = `https://eco-tags.onrender.com`;
//
// cron.schedule("0 */15 * * * *", () => {
//   axios
//     .get(link_to_site, {
//       headers: { "Accept-Encoding": "gzip,deflate,compress" },
//     })
//     .then((req, res) => {
//       console.log(`ok`);
//     })
//     .catch((err) => {
//       // console.log(err)
//     });
// });
//
// // --------------------------------------------------------------------------------------------------//

app.post("/addUser", async (req, res) => {
  const user = usersDb.doc(req.body.username);
  const doc = await user.get();
  if (doc.exists) {
    return res.status(400).send({
      message: "User Name is already taken",
    });
  } else {
    var index = Math.floor(Math.random() * pfp.length);
    var pfpUrl = pfp[index];
    // console.log(pfpUrl);
    try {
      await usersDb.doc(req.body.id).set({
        email: req.body.email,
        username: req.body.username, //must be unique, user is stored with Data ID as Username so as to access updation and other features.
        first_name: req.body.first_name,
        last_name: req.body.last_name,
        age: req.body.age,
        rank: req.body.rank,
        pfpUrl: pfpUrl,
        points: 0,
        id: req.body.id,
      });

      return res.status(200).json({
        message: "User successfully added",
      });
    } catch (err) {
      console.log(err);
    }
  }
});

app.get("/getUser", authorizeUser, async (req, res) => {
  try {
    var user_id = req.user_id;
    // console.log(req.user_id)
    const user = usersDb.doc(req.user_id);

    const doc = await user.get();

    if (doc.exists) {
      var response = doc.data();
      response["pictures"] = [];
      const userImages = await imageDb.where(
        "user_id", "==", user_id
      ).get();
      // sorting the images by timestamp
      for (var i = 0; i < userImages.docs.length; i++) {
        for (var j = i + 1; j < userImages.docs.length; j++) {
          if (
            userImages.docs[i].data().timestamp <
            userImages.docs[j].data().timestamp
          ) {
            var temp = userImages.docs[i];
            userImages.docs[i] = userImages.docs[j];
            userImages.docs[j] = temp;
          }
        }
      }
      for(var i=0;i<userImages.docs.length;i++){
        var data = userImages.docs[i].data();
        console.log(data.timestamp);
        response["pictures"].push({
          url: data.url,
          id: userImages.docs[i].id,
          timestamp: data.timestamp,
          verified: data.verified,
        });
      }

      res.status(200).json(response);
    } else {
      res.status(404).send("user_not_found");
    }
  } catch (err) {
    console.log(err);
  }
});

app.get("/", async (req, res) => {
  res.json({
    "available routes": {
      home: "/",
      "get geo-Locations of posted images on database": "/getLocations",
      "add Users to database": "/addUser",
      "update rank of a given user with username": "/updateUser",
      "add Images to the database with url of firestore": "/addImage",
    },
  });
});

app.post("/addImage", authorizeUser, async (req, res) => {
  try {
    const id = uuidv4();

    imageDb
      .doc(id)
      .set({
        user_id: req.user_id,
        url: req.body.url,
        latitude: req.body.latitude,
        longitude: req.body.longitude,
        verified: false,
        timestamp: new Date(),
        num_verified: 0,
      })
      .then(res.status(201).send("image_added"))
      .catch((err) => {
        console.log(err);
        res.status(500).send("image_not_added");
      });

    // verifyImages(
    //   id,
    //   req.body.geotagLat,
    //   req.body.geotagLong,
    //   req.body.rank,
    //   req.body.username
    // );
  } catch (err) {
    console.log(err);
  }
});

app.put("/updateUser", async (req, res) => {
  try {
    const rank = usersDb.doc(req.body.username);
    await rank.update({
      rank: req.body.rank,
    });
    res.status(200).send("user_updated");
  } catch (err) {
    console.log(err);
  }
});

async function verifyImages(id, lat, long, rank, username) {
  try {
    const tags = imageDb;
    const data = await tags.get();
    const usersData = await usersDb.get();
    data.forEach((doc) => {
      if (
        doc.id != id &&
        doc.data().verified == "false" &&
        doc.data().username != username
      ) {
        if (lat == doc.data().geotagLat && long == doc.data().geotagLong) {
          console.log(doc.id);
          if (rank == "moderator") {
            imageDb.doc(doc.id).update({ verified: "true" });
            user = doc.data().username;

            usersData.forEach((u) => {
              if (u.data().username == user) {
                var p = u.data().points + 10;
                usersDb.doc(u.id).update({ points: p });
              }
            });
          } else {
            var x = doc.data().numVer + 1;
            imageDb.doc(doc.id).update({ numVer: x });
            if (x >= 5) {
              imageDb.doc(doc.id).update({ verified: "true" });
              user = doc.data().username;

              usersData.forEach((u) => {
                if (u.data().username == user) {
                  var p = u.data().points + 10;
                  usersDb.doc(u.id).update({ points: p });
                }
              });
            }
          }
        }
      }
    });
  } catch {}
}

app.get("/getLocations", authorizeUser, async (req, res) => {
  try {
    const images = await imageDb.get();
    const usersData = await usersDb.get();
    let arr = [];
    images.forEach((doc) => {
      const locationData = doc.data();
      // get userDetails
      var userDetails;
      usersData.forEach((user) => {
        console.log(user.data().id, locationData.user_id);
        if (user.data().id === locationData.user_id) {
          userDetails = user.data();
        }
      });
      if (userDetails === undefined) {
        userDetails = {
          username: "anonymous",
          rank: "user",
          pfpUrl: pfp[Math.floor(Math.random() * pfp.length)],
        };
      } else {
        userDetails = userDetails;
      }
      var body = {
        id: doc.id,
        longitude: locationData.longitude,
        latitude: locationData.latitude,
        verification_status: locationData.verified,
        timestamp: locationData.timestamp,
        username: userDetails.username,
        rank: userDetails.rank,
        pfpUrl: userDetails.pfpUrl,
      };

      if (locationData.user_id === req.user_id) {
        console.log(locationData.user_id, req.user_id);
        body.location_type = "SELF";
        // get username from usersData

        // body.username =
      } else {
        body.location_type = "OTHER";
      }
      arr.push(body);
    });
    // get user_name from user_id
    console.log(arr);
    res.json(arr);
  } catch (err) {
    console.log(err);
    res.status(500).send({
      message: err.message || "Some error occurred while retrieving locations.",
    });
  }
});

app.get("/userImages", authorizeUser, async (req, res) => {
  try {
    const userId = req.body.id;
    const images = await imageDb.get();
    var userImages = [];
    images.forEach((doc) => {
      const imageUrl = doc.data().url;
      const userID_inImages = doc.data().user_id;
      if (userID_inImages === userId) {
        userImages.push(imageUrl);
      }
    });
    res.status(200).json(userImages);
  } catch (err) {
    console.log(err);
  }
});

app.listen(PORT, () => {
  console.log(`listening on port ${PORT}`);
});
