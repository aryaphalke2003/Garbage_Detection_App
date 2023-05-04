// import 'package:ecotags/screens/social/banner.dart';
// import 'package:ecotags/screens/social/banners.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   testWidgets('BannersViewer widget displays banners', (WidgetTester tester) async {
//     // Build the widget tree
//     await tester.pumpWidget(MaterialApp(
//       home: BannersViewer(),
//     ));

//     // Verify that the widget displays the "REDEEM POINTS" banner and four `BannerViewer` widgets
//     expect(find.text("REDEEM POINTS"), findsOneWidget);
//     expect(find.byType(BannerViewer), findsNWidgets(4));

//     // Verify that the `BannerViewer` widgets display the correct data
//     final socialInitiativesBanner = find.widgetWithText(BannerViewer, "Social Initiatives");
//     expect(socialInitiativesBanner, findsOneWidget);
//     expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == "assets/icons/social_initiatives/marathon.png"), findsOneWidget);
//     expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == "assets/icons/social_initiatives/ocean.png"), findsOneWidget);
//     expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == "assets/icons/social_initiatives/plantation.png"), findsOneWidget);

//     final partnersAndPerksBanner = find.widgetWithText(BannerViewer, "Partners & Perks");
//     expect(partnersAndPerksBanner, findsOneWidget);
//     expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == "assets/icons/partners_and_perks/grocery.png"), findsOneWidget);
//     expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == "assets/icons/partners_and_perks/juice.png"), findsOneWidget);
//     expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == "assets/icons/partners_and_perks/vegan.png"), findsOneWidget);

//     final goodiesBanner = find.widgetWithText(BannerViewer, "Goodies");
//     expect(goodiesBanner, findsOneWidget);
//     expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == "assets/icons/goodies/bag.png"), findsOneWidget);
//     expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == "assets/icons/goodies/cup.png"), findsOneWidget);
//     expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == "assets/icons/goodies/shirt.png"), findsOneWidget);

//     final achievementsBanner = find.widgetWithText(BannerViewer, "Achievements");
//     expect(achievementsBanner, findsOneWidget);
//     expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == "assets/icons/achievements/badge.jpg"), findsOneWidget);
//     expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == "assets/icons/achievements/check.png"), findsOneWidget);
//     expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == "assets/icons/achievements/verify.png"), findsOneWidget);
//   });
// }