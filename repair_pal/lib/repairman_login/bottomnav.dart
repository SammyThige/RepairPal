import 'package:flutter/material.dart';
import 'package:repair_pal/AppointmentPage/appointment.dart';
import 'package:repair_pal/ChatsPage/chats.dart';
import 'package:repair_pal/HomePage/components/appbar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:repair_pal/UserProfile/testprofile.dart';
import 'package:repair_pal/constants.dart';
import 'package:repair_pal/repairman_login/components/set_photo_screens.dart';
import 'package:repair_pal/repairman_login/portfolio.dart';
import 'package:repair_pal/repairman_login/rm_profile.dart';
//import 'package:flutter/material.dart';
//import 'package:repair_pal/test.dart';
//import 'package:repair_pal/HomePage/components/bottomnav.dart';
//import 'package:repair_pal/HomePage/homepage.dart';

class RMdash extends StatefulWidget {
  const RMdash({super.key});

  @override
  State<RMdash> createState() => _RMdashState();
}

class _RMdashState extends State<RMdash> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppToolBar(),
      body: Body(),
    );
  }
}

class RMPage extends StatefulWidget {
  RMPage({super.key});

  @override
  State<RMPage> createState() => _RMPageState();
}

class _RMPageState extends State<RMPage> {
  int index = 0;

  final screens = const [
    AppointmentPage(),
    //will change to adding pics and showing previous work
    SetPhotoScreen(),
    RMProfile(),
    ChatsPage()
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: SizedBox(
          height: 70,
          child: Container(
            width: size.width * 0.8,
            child: GNav(
              backgroundColor: Colors.transparent,
              color: kPrimaryColor,
              activeColor: Colors.white,
              curve: Curves.easeOutExpo,
              duration: Duration(milliseconds: 200),
              tabBackgroundColor: Colors.orange.withOpacity(0.5),
              gap: 8,
              onTabChange: (index) => setState(() => this.index = index),
              tabs: const [
                GButton(icon: Icons.home, text: "Schedule"),
                GButton(icon: Icons.nature, text: "Add"),
                GButton(icon: Icons.settings, text: "Profile"),
                GButton(icon: Icons.message, text: "Chats")
              ],
            ),
          )),
    );
  }
}
