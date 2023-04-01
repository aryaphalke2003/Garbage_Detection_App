import 'package:flutter/material.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const SizedBox(height: 100),
      Container(
          padding: const EdgeInsets.only(top: 200.0),
          // color: backgroundColor,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logo.png'),
              fit: BoxFit.fitWidth,
              // alignment: Alignment.topCenter,
            ),
          ))
    ]);
  }
}
