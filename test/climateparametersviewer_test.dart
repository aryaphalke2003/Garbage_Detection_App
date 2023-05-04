// import 'package:ecotags/screens/home/climateparametersviewer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// void main() {
//   testWidgets('ClimateParametersViewer displays correct values',
//       (WidgetTester tester) async {
//     final int aqi = 50;
//     final double temperature = 25.0;

//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: ClimateParametersViewer(
//             aqi: aqi,
//             temperature: temperature,
//           ),
//         ),
//       ),
//     );

//     expect(find.text('$aqi' + 'AQI'), findsOneWidget);
//     expect(find.text('$temperature' + '°C'), findsOneWidget);
//   });
// }