import 'package:ecotags/const/color.dart';
import 'package:ecotags/screens/background.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:ecotags/screens/home.dart';

class SignUpScreen extends StatefulWidget {
  static String tag = 'register-page';
  @override
  _SignUpScreenState createState() => new _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();
  final emailTextEditController = new TextEditingController();
  final firstNameTextEditController = new TextEditingController();
  final lastNameTextEditController = new TextEditingController();
  final passwordTextEditController = new TextEditingController();
  final confirmPasswordTextEditController = new TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String _errorMessage = '';

  void processError(final PlatformException error) {
    setState(() {
      _errorMessage = error.message!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(children: <Widget>[
          BackgroundScreen(),
          Container(
              height: MediaQuery.of(context).size.height * 3 / 4,
              margin: EdgeInsets.only(top: 300.0),
              padding: EdgeInsets.only(
                top: 10.0,
              ),
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0))),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.only(top: 10.0, left: 24.0, right: 24.0),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 36.0,
                              color: appColor),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '$_errorMessage',
                          style: TextStyle(fontSize: 14.0, color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email.';
                              }
                              return null;
                            },
                            controller: emailTextEditController,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                            focusNode: _emailFocus,
                            onFieldSubmitted: (term) {
                              FocusScope.of(context)
                                  .requestFocus(_firstNameFocus);
                            },
                            decoration: buttonDecoration("Input your email"),
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your first name.';
                            }
                            return null;
                          },
                          controller: firstNameTextEditController,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          textInputAction: TextInputAction.next,
                          focusNode: _firstNameFocus,
                          onFieldSubmitted: (term) {
                            FocusScope.of(context).requestFocus(_lastNameFocus);
                          },
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your last name.';
                            }
                            return null;
                          },
                          controller: lastNameTextEditController,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          textInputAction: TextInputAction.next,
                          focusNode: _lastNameFocus,
                          onFieldSubmitted: (term) {
                            FocusScope.of(context).requestFocus(_passwordFocus);
                          },
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.length < 8) {
                              return 'Password must be longer than 8 characters.';
                            }
                            return null;
                          },
                          autofocus: false,
                          obscureText: true,
                          controller: passwordTextEditController,
                          textInputAction: TextInputAction.next,
                          focusNode: _passwordFocus,
                          onFieldSubmitted: (term) {
                            FocusScope.of(context)
                                .requestFocus(_confirmPasswordFocus);
                          },
                          decoration: InputDecoration(
                            hintText: 'Password',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          autofocus: false,
                          obscureText: true,
                          controller: confirmPasswordTextEditController,
                          focusNode: _confirmPasswordFocus,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (passwordTextEditController.text.length > 8 &&
                                passwordTextEditController.text != value) {
                              return 'Passwords do not match.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: EdgeInsets.all(12),
                            backgroundColor: Colors.lightGreen,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _firebaseAuth
                                  .createUserWithEmailAndPassword(
                                      email: emailTextEditController.text,
                                      password: passwordTextEditController.text)
                                  .then((onValue) {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(onValue.user!.uid)
                                    .set({
                                  'firstName': firstNameTextEditController.text,
                                  'lastName': lastNameTextEditController.text,
                                }).then((userInfoValue) {
                                  Navigator.of(context)
                                      .pushNamed(HomeScreen.tag);
                                });
                              }).catchError((onError) {
                                print(onError);
                              });
                            }
                          },
                          child: Text('Sign Up'.toUpperCase(),
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.zero,
                          child: TextButton(
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black54),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ))
                    ],
                  ))),
        ]));
  }
}

InputDecoration buttonDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
  );
}
