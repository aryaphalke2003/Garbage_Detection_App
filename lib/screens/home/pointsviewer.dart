import 'package:ecotags/providers/MapProvider.dart';
import 'package:ecotags/providers/user/UserDetailsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class PointsViewer extends StatelessWidget {
  // points class variable
  final int points;

  const PointsViewer({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsProvider>(builder: (context, user, child) {
      return Container(
        width: 45,
        height: 45,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: <Widget>[
            Text(
              'Points',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            Text(
              user.points.toString(),
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    });
  }
}
