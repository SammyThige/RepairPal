import 'package:flutter/material.dart';
import 'package:repair_pal/AppointmentPage/appointment.dart';
import 'package:repair_pal/ChatsPage/chats.dart';
import 'package:repair_pal/HomePage/components/appbar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:repair_pal/UserProfile/userprofile.dart';
import 'package:repair_pal/constants.dart';
//import 'package:flutter/material.dart';
//import 'package:repair_pal/test.dart';
//import 'package:repair_pal/HomePage/components/bottomnav.dart';
//import 'package:repair_pal/HomePage/homepage.dart';

class HomeDashPage extends StatefulWidget {
  const HomeDashPage({super.key});

  @override
  State<HomeDashPage> createState() => _HomeDashPageState();
}

class _HomeDashPageState extends State<HomeDashPage> {
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

  final screens = const [
    HomeDashPage(),
    AppointmentPage(),
    MyProfile(),
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
                GButton(icon: Icons.home, text: "Home"),
                GButton(icon: Icons.nature, text: "Projects"),
                GButton(icon: Icons.settings, text: "Settings"),
                GButton(icon: Icons.message, text: "Chats")
              ],
            ),
          )),
    );
  }
}
