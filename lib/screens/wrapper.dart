// if user is authenticated then show home screen
// if user is not authenticated then show login screen

import 'package:ecotags/providers/user/UserDetailsProvider.dart';
import 'package:ecotags/screens/home.dart';
import 'package:ecotags/screens/login.dart';
import 'package:ecotags/screens/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      print("User is not authenticated");
      return WelcomeScreen();
    } else {
      // get user details, set in provider

      return HomeScreen();
    }
  }
}
