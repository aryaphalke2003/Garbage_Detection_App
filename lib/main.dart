import 'package:ecotags/const/color.dart';
import 'package:ecotags/providers/MapProvider.dart';
import 'package:ecotags/providers/camera/CameraProvider.dart';
import 'package:ecotags/providers/user/UserDetailsProvider.dart';
import 'package:ecotags/screens/home.dart';
import 'package:ecotags/screens/login.dart';
import 'package:ecotags/screens/signup.dart';
import 'package:ecotags/screens/welcome.dart';
import 'package:ecotags/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  String _darkMapStyle =
      await rootBundle.loadString('assets/map_styles/dark.json');

  await Firebase.initializeApp();
  List<CameraDescription> cameras = await availableCameras();
  runApp(MyApp(
    camera: cameras.first,
    mapStyle: _darkMapStyle,
  ));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;
  final String mapStyle;

  const MyApp({super.key, required this.camera, required this.mapStyle});

  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      HomeScreen.tag: (context) => HomeScreen(),
      SignUpScreen.tag: (context) => SignUpScreen(),
      WelcomeScreen.tag: (context) => WelcomeScreen(),
    };

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserDetailsProvider>(
              create: (_) => UserDetailsProvider()),
          ChangeNotifierProvider<CameraProvider>(
              create: (_) => CameraProvider(
                    camera: camera,
                  )),
          ChangeNotifierProvider(
              create: (_) => MapProvider(
                    mapStyle: mapStyle,
                  )),
        ],
        child: MaterialApp(
          title: 'Eco Tags',
          theme: ThemeData(
            backgroundColor: backgroundColor,
            primaryColor: primaryColor,
            fontFamily: 'GoogleSans',
            // primarySwatch: appColor
          ),
          home: Wrapper(),
          routes: routes,
        ),
      ),
    );
  }
}
