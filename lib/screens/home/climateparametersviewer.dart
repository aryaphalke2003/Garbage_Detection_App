import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ClimateParametersViewer extends StatelessWidget {
  final int aqi;
  final double temperature;

  const ClimateParametersViewer(
      {required this.aqi, required this.temperature, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            aqi.toString() + 'AQI',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          Text(
            temperature.toString() + '°C',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
