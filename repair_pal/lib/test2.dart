import 'package:flutter/material.dart';
import 'package:repair_pal/HomePage/components/appbar.dart';
//import 'package:repair_pal/HomePage/components/bottomnav.dart';
import 'package:repair_pal/test.dart';
//import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
//import 'package:repair_pal/HomePage/homepage.dart';
import 'package:repair_pal/constants.dart';
//import 'package:repair_pal/test.dart';

class HomeDashPage extends StatelessWidget {
  const HomeDashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppToolBar(),
      body: Body(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final screens = [HomeDashPage(), TestWidget()];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: SizedBox(
          height: 70,
          child: Container(
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
              //tabBackgroundGradient: ,
              tabBackgroundColor: Colors.orange.withOpacity(0.5),
              gap: 8,
              onTabChange: (index) => setState(() => this.index = index),
              /* onTabChange: (index) {
          print(index);
        }, */

              tabs: const [
                GButton(icon: Icons.home, text: "Home"),
                //GButton(icon: Icons.favorite_border, text: "Likes"),
                GButton(icon: Icons.message, text: "Chats"),
                GButton(icon: Icons.settings, text: "Settings")
              ],
            ),
          )),
    );
  }
}

/* class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  //final screens = [HomePage(), TestWidget()];

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
        //tabBackgroundGradient: ,
        tabBackgroundColor: Colors.orange.withOpacity(0.5),
        gap: 8,
        onTabChange: (index) => setState(() => this.index = index),
        /* onTabChange: (index) {
          print(index);
        }, */

        tabs: const [
          GButton(icon: Icons.home, text: "Home"),
          //GButton(icon: Icons.favorite_border, text: "Likes"),
          GButton(icon: Icons.message, text: "Chats"),
          GButton(icon: Icons.settings, text: "Settings")
        ],
      ),
    );
  }
}
 */