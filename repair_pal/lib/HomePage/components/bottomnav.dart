import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:repair_pal/constants.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // margin: EdgeInsets.symmetric(vertical: 10),
      //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      // color: kPrimaryColor,
      child: GNav(
        backgroundColor: Colors.transparent,
        color: kPrimaryColor,
        activeColor: Colors.white,
        curve: Curves.easeOutExpo,
        duration: Duration(milliseconds: 200),
        tabBackgroundColor: Colors.orange,
        gap: 8,
        onTabChange: (index) {
          print(index);
        },
        tabs: const [
          GButton(icon: Icons.home, text: "Home"),
          GButton(icon: Icons.favorite_border, text: "Likes"),
          GButton(icon: Icons.search, text: "Search"),
          GButton(icon: Icons.settings, text: "Settings")
        ],
      ),
    );
  }
}
