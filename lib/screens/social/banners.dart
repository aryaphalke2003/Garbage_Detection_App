import 'package:ecotags/const/color.dart';
import 'package:flutter/material.dart';
import 'banner.dart';

class BannersViewer extends StatelessWidget {
  const BannersViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: const Center(
              child: Text(
                "REDEEM POINTS",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              BannerViewer(
                  heading: "Social Initiatives",
                  icon1: 'assets/icons/social_initiatives/marathon.png',
                  icon2: 'assets/icons/social_initiatives/ocean.png',
                  icon3: 'assets/icons/social_initiatives/plantation.png'),
              BannerViewer(
                  heading: "Partners & Perks",
                  icon1: 'assets/icons/partners_and_perks/grocery.png',
                  icon2: 'assets/icons/partners_and_perks/juice.png',
                  icon3: 'assets/icons/partners_and_perks/vegan.png'),
              BannerViewer(
                  heading: "Goodies",
                  icon1: 'assets/icons/goodies/bag.png',
                  icon2: 'assets/icons/goodies/cup.png',
                  icon3: 'assets/icons/goodies/shirt.png'),
              BannerViewer(
                  heading: "Achievements",
                  icon1: 'assets/icons/achievements/badge.jpg',
                  icon2: 'assets/icons/achievements/check.png',
                  icon3: 'assets/icons/achievements/verify.png'),
            ],
          ),
        ],
      ),
    );
  }
}
