const { getAuth } = require("firebase-admin/auth");

async function authorizeUser(req, res, next) {
  // Get token from header
  let idToken = req.header("Authorization");

  if (!idToken) {
    return res.status(401).json({
      message: "Access Denied",
      error: "No token provided",
    });
  } else {
    idToken = idToken.split(" ")[1];
    console.log(idToken);

    try {
      const decodedToken = await getAuth().verifyIdToken(idToken);
      const uid = decodedToken.uid;
      req.user_id = uid;
      next();
    } catch (error) {
      console.log(error);
      return res.status(401).json({
        message: "Access Denied",
        error: "Invalid token",
      });
    }
  }
}

module.exports = {
  authorizeUser,
};
