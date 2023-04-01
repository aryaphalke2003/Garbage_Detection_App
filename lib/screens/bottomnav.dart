import 'package:ecotags/const/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// create a custom button widget over google nav bar
class CustomNavButton extends GButton {
  const CustomNavButton(
      {super.key,
      required IconData icon,
      required String text,
      Color? iconColor = Colors.white,
      Color? textColor = Colors.white,
      Color? backgroundColor,
      onPressed})
      : super(
          icon: icon,
          text: text,
          iconColor: iconColor,
          textColor: textColor,
          backgroundColor: backgroundColor,
          onPressed: onPressed,
        );
}

List<CustomNavButton> bottomNavItems = [
  CustomNavButton(
    icon: CupertinoIcons.search,
    text: 'Search',
  ),
  CustomNavButton(
    icon: CupertinoIcons.camera,
    text: 'Camera',
  ),
  CustomNavButton(
    icon: CupertinoIcons.home,
    text: 'Home',
  ),
  CustomNavButton(
    icon: CupertinoIcons.person,
    text: 'Profile',
  ),
];

Widget buildBottomNav(void Function(int) onTabChanged) {
  return GNav(
      gap: 4,
      backgroundColor: appColor,
      activeColor: Colors.white,
      iconSize: 25,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      duration: Duration(milliseconds: 800),
      tabBackgroundColor: Colors.grey[800]!,
      // tabBackgroundColor: Colors.grey[800],
      tabs: bottomNavItems,
      selectedIndex: 2,
      onTabChange: onTabChanged);
}
