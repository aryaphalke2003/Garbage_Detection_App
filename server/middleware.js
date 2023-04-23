var {getAuth} = require("firebase-admin/auth");

async function authorizeUser(req, res, next) {
    // get token from header
    // let idToken = req.header("Authorization");
    //
    //
    // if (!idToken) {
    //   return res.status(401).json({
    //     message: "Access Denied",
    //     error: "No token provided",
    //   });
    // } else {
    //   idToken = idToken.split(" ")[1];
    //   console.log(idToken)
    //   getAuth()
    //     .verifyIdToken(idToken)
    //     .then((decodedToken) => {
    //       const uid = decodedToken.uid;
    //       req.user_id = uid;
    //       next();
    //     })
    //     .catch((error) => {
    //       console.log(error);
    //       return res.status(401).json({
    //         message: "Access Denied",
    //         error: "Invalid token",
    //       });
    //     });
    // }
  }


module.exports = {
    authorizeUser
}
