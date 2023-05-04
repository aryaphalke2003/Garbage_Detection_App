// import 'package:ecotags/screens/profile/PhotoGallery.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   group('PictureGallery', () {
//     testWidgets('should display pictures in a grid', (WidgetTester tester) async {
//       final pictures = [
//         Picture(const Image(
//   image: AssetImage('assets/image.png'),
// ) as String, 'Image 1', 37.4219999, -122.0840575),
//         // Picture('https://lh3.googleusercontent.com/proxy/Ck5mAJcvh0hmIgEfrwtt0kQftFeKp0bmtbDcwjpa3nN7Zrk3rdzPITaYpGLqAOY-ptw98Nb02Yf2l--SEN4C06M0siUW-AwQCAzwBRadSAxqjMwjTcosn4gXkG15m5H2L3PU_wfakB4FjC6_eRNzYKWqRkNWIZ5Cdp00Rn0=w3840-h2160-p-k-no-nd-mv', 'Image 2', 37.4220000, -122.0840576),
//         // Picture('https://lh3.googleusercontent.com/proxy/Ck5mAJcvh0hmIgEfrwtt0kQftFeKp0bmtbDcwjpa3nN7Zrk3rdzPITaYpGLqAOY-ptw98Nb02Yf2l--SEN4C06M0siUW-AwQCAzwBRadSAxqjMwjTcosn4gXkG15m5H2L3PU_wfakB4FjC6_eRNzYKWqRkNWIZ5Cdp00Rn0=w3840-h2160-p-k-no-nd-mv', 'Image 3', 37.4220001, -122.0840577),
//       ];

//       await tester.pumpWidget(MaterialApp(
//         home: PictureGallery(pictures: pictures),
//       ));

//       // Verify that the grid contains all pictures
//       expect(find.byType(Container), findsNWidgets(pictures.length));

//       // Verify that each picture is displayed with a border and a network image
//       for (int i = 0; i < pictures.length; i++) {
//         final container = find.byType(Container).at(i);
//         final decoration = (container.evaluate().first.widget as Container).decoration;
//         final image = (decoration as BoxDecoration).image as DecorationImage;

//         expect(decoration.border, isA<Border>());
//         expect(image, isA<DecorationImage>());
//         expect(image.image, isA<NetworkImage>());
//         expect((image.image as NetworkImage).url, pictures[i].image);
//       }
//     });
//   });
// }