import 'package:ecotags/const/color.dart';
import 'package:ecotags/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home.dart';

class LoginBottomScreen extends StatefulWidget {
  const LoginBottomScreen({super.key});

  @override
  State<LoginBottomScreen> createState() => _LoginBottomScreenState();
}

class _LoginBottomScreenState extends State<LoginBottomScreen> {
  final TextEditingController emailController = new TextEditingController();

  final TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String _errorMessage = '';
  bool _isPasswordVisible = true;

  void onChange() {
    setState(() {
      _errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Text(
                "Welcome back!",
                style: TextStyle(color: appColor, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Login",
                style: TextStyle(
                    color: appColor, fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: appColor, width: 2.0),
                      ),
                      labelStyle: TextStyle(
                        color: appColor,
                      ),
                      border: OutlineInputBorder(),
                      labelText: "EMAIL",
                      hintText: "Enter your email",
                      // add validation
                      suffixIcon: IconButton(
                        icon: Icon(CupertinoIcons.mail),
                        onPressed: () {},
                        color: appColor,
                      ))),
              SizedBox(
                height: 20,
              ),
              TextField(
                  obscureText: _isPasswordVisible,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: passwordController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: appColor, width: 2.0),
                      ),
                      labelStyle: TextStyle(
                        color: appColor,
                      ),
                      border: OutlineInputBorder(),
                      labelText: "PASSWORD",
                      hintText: "Enter your password",
                      // add validation
                      suffixIcon: IconButton(
                        icon: Icon(CupertinoIcons.eye_fill),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        color: appColor,
                      ))),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    print("email: ${emailController.text}");
                    print("Password: ${passwordController.text}");
                    signIn(emailController.text, passwordController.text)
                        .then((uid) =>
                            {Navigator.of(context).pushNamed(HomeScreen.tag)})
                        .catchError((error) => {processError(error)});
                    // if (_formKey.currentState!.validate()) {
                    //   // print('email: ${emailController}');
                    //   // print('Password: ${passwordController}');
                    //   print("Button Pressed");
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 20, color: appColor),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // make a forgot password button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: appColor, fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: extraColor, fontSize: 20),
                    ),
                  )
                ],
              )
            ]));
  }

  void processError(final PlatformException error) {
    if (error.code == "ERROR_USER_NOT_FOUND") {
      setState(() {
        _errorMessage = "Unable to find user. Please register.";
      });
    } else if (error.code == "ERROR_WRONG_PASSWORD") {
      setState(() {
        _errorMessage = "Incorrect password.";
      });
    } else {
      setState(() {
        _errorMessage =
            "There was an error logging in. Please try again later.";
      });
    }
  }

  Future<String> signIn(final String email, final String password) async {
    User? user = (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user!.uid;
  }
}
