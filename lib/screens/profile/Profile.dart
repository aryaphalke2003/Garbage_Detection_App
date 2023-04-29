// import 'package:ecotags/const/color.dart';
// import 'package:ecotags/providers/user/UserDetailsProvider.dart';
// import 'package:ecotags/screens/profile/PhotoGallery.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:ecotags/screens/welcome.dart';

// class Profile extends StatefulWidget {
//   @override
//   _ProfileState createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserDetailsProvider>(
//       builder: (context, user, child) {
//         return Scaffold(
//           backgroundColor: backgroundColor,
//           body: Container(
//             padding: EdgeInsets.only(top: 50, left: 20, right: 20),
//             child: Column(
//               children: [
//                 Flexible(
//                   flex: 1,
//                   child: Row(
//                     children: [
//                       Flexible(
//                         flex: 2,
//                         child: Container(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             children: <Widget>[
//                               Container(
//                                 child: Text(
//                                   '@${user.firstName}',
//                                   style: TextStyle(
//                                     color: primaryColor,
//                                     fontSize: 18,
//                                     fontStyle: FontStyle.italic,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               CircleAvatar(
//                                 radius: 50,
//                                 backgroundImage: AssetImage(
//                                   'assets/user.jpg',
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Flexible(
//                         flex: 3,
//                         child: Container(
//                           padding: EdgeInsets.only(left: 20, right: 20),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     '${user.points} Points',
//                                     style: TextStyle(
//                                       color: Colors.blueGrey[400],
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                   SizedBox(height: 5),
//                                   Text(
//                                     user.rank,
//                                     style: TextStyle(
//                                       color: Colors.blueGrey[400],
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.logout),
//                                 color: Colors.white,
//                                 onPressed: () async {
//                                   await FirebaseAuth.instance.signOut();
//                                   Navigator.of(context).pushNamed(WelcomeScreen.tag);
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Flexible(
//                   flex: 3,
//                   child: Column(
//                     children: [
//                       Flexible(
//                         flex: 1,
//                         child: Container(
//                           alignment: Alignment.center,
//                           width: double.infinity,
//                           color: primaryColor,
//                           child: Text(
//                             'Saved Images',
//                             style: TextStyle(
//                               color: appColor,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Flexible(
//                         flex: 11,
//                         child: PictureGallery(pictures: user.pictures),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

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

  // void _showImageDetailsDialog(Picture picture) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Image Details"),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text("Location: ${picture.location}"),
  //             SizedBox(height: 10),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 ElevatedButton(
  //                   child: Text("Delete"),
  //                   onPressed: () {
  //                     // handle deletion logic here
  //                     Navigator.pop(context); // close dialog
  //                   },
  //                 ),
  //                 ElevatedButton(
  //                   child: Text("Close"),
  //                   onPressed: () {
  //                     Navigator.pop(context); // close dialog
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  void _showImageDetailsDialog(Picture picture) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Image Details'),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                picture.image,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text('Location: ${picture.latitude} ${picture.longitude}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Delete'),
            onPressed: () {
              // Implement delete functionality here
            },
          ),
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsProvider>(
      builder: (context, user, child) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Container(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  '@${user.firstName}',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage(
                                  'assets/user.jpg',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${user.points} Points',
                                    style: TextStyle(
                                      color: Colors.blueGrey[400],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    user.rank,
                                    style: TextStyle(
                                      color: Colors.blueGrey[400],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(Icons.logout),
                                color: Colors.white,
                                onPressed: () async {
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.of(context)
                                      .pushNamed(WelcomeScreen.tag);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          color: primaryColor,
                          child: Text(
                            'Saved Images',
                            style: TextStyle(
                              color: appColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // Flexible(
                      //   flex: 11,
                      //   child: PictureGallery(pictures: user.pictures),
                      // ),
                      Flexible(
                        flex: 11,
                        child: GridView.count(
                          crossAxisCount: 3,
                          children: List.generate(
                            user.pictures.length,
                            (index) {
                              return GestureDetector(
                                child: Image.network(
                                  user.pictures[index].image,
                                  fit: BoxFit.cover,
                                ),
                                onTap: () {
                                  _showImageDetailsDialog(user.pictures[index]);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
