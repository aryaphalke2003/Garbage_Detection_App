import 'package:ecotags/const/color.dart';
import 'package:ecotags/providers/user/UserDetailsProvider.dart';
import 'package:ecotags/screens/profile/PhotoGallery.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecotags/screens/welcome.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsProvider>(builder: (context, user, child) {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          padding: EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(
                                    'assets/user.jpg',
                                  )
                                  // NetworkImage(user.pfpUrl),
                                  ),
                            ),
                            Container(
                              child: Text(
                                user.firstName,
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text(
                                user.rank,
                                style: TextStyle(
                                    color: Colors.blueGrey[400],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: Container(
                          padding: EdgeInsets.all(8.0),
                          // padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                          // show points and username in a column
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  '@${user.firstName}',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '${user.points} Points',
                                  style: TextStyle(
                                      color: Colors.blueGrey[400],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                  child: IconButton(
                                icon: Icon(Icons.logout),
                                color: Colors.white,
                                onPressed: () async {
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.of(context)
                                      .pushNamed(WelcomeScreen.tag);
                                },
                              )),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Flexible(
                  flex: 3,

                  // iterate over array and generate a grid of images

                  child: Column(
                    // iterate over array and generate a grid of images

                    children: [
                      // green divider
                      Flexible(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            // padding: EdgeInsets.only(top: 20),
                            color: primaryColor,
                            child: Text(
                              'Saved Images',
                              style: TextStyle(
                                  color: appColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                            // child: Divider(thickness: 5, color: primaryColor),
                            ),
                      ),
                      Flexible(
                          flex: 11,
                          child: PictureGallery(pictures: user.pictures)
                          // child: ImageGallery(),
                          )
                    ],
                  )),
              // Flexible(
              //     flex: 4,
              //     child: Container(
              //       color: Colors.white,
              //     )),
            ],
          ),
        ),
      );
    });
  }
}


// class ProfilePage extends StatelessWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Welcome to your profile!'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               child: Text('Logout'),
//               onPressed: () async {
//                 await _firebaseAuth.signOut();
//                 Navigator.of(context).pushNamed(WelcomeScreen.tag);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
