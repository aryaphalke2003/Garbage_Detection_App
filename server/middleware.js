// const { getAuth } = require("firebase-admin/auth");

// async function authorizeUser(req, res, next) {
//   // Get token from header
//   let idToken = req.header("Authorization");

//   if (!idToken) {
//     return res.status(401).json({
//       message: "Access Denied",
//       error: "No token provided",
//     });
//   } else {
//     idToken = idToken.split(" ")[1];
//     console.log(idToken);

//     try {
//       const decodedToken = await getAuth().verifyIdToken(idToken);
//       const uid = decodedToken.uid;
//       req.user_id = uid;
//       next();
//     } catch (error) {
//       console.log(error);
//       return res.status(401).json({
//         message: "Access Denied",
//         error: "Invalid token",
//       });
//     }
//   }
// }

// module.exports = {
//   authorizeUser,
// };


const admin = require('firebase-admin');
const serviceAccount = require('../server/cs305-ecotags-firebase-adminsdk-89k2k-c6840e88c0.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const { getAuth } = require("firebase-admin/auth");

const ACCESS_DENIED = "Access denied";
const NO_TOKEN_PROVIDED = "No token provided";
const INVALID_TOKEN = "Invalid token";

async function authorizeUser(req, res, next) {
  const idToken = req.header("Authorization")?.split(" ")[1];

  if (!idToken) {
    return res.status(401).json({
      message: ACCESS_DENIED,
      error: NO_TOKEN_PROVIDED,
    });
  }

  try {
    const { uid } = await getAuth().verifyIdToken(idToken);
    req.user_id = uid;
    next();
  } catch (error) {
    console.error(error);
    return res.status(401).json({
      message: ACCESS_DENIED,
      error: INVALID_TOKEN,
    });
  }
}

module.exports = {
  authorizeUser,
};

