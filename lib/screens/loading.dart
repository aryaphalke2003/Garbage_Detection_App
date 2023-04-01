// make a circular loading page

import 'package:ecotags/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoadingWidget extends StatefulWidget {
  final String message;
  const LoadingWidget({super.key, required this.message});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: Center(
        // make a loader with message

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: primaryColor,
            ),
            Text(widget.message,
                style: TextStyle(color: primaryColor, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
