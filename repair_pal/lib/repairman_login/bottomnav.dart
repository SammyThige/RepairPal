import 'package:flutter/material.dart';
import 'package:repair_pal/AppointmentPage/appointment.dart';
import 'package:repair_pal/ChatsPage/chats.dart';
import 'package:repair_pal/HomePage/components/appbar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:repair_pal/UserProfile/testprofile.dart';
import 'package:repair_pal/constants.dart';
import 'package:repair_pal/repairman_login/components/set_photo_screens.dart';
import 'package:repair_pal/repairman_login/portfolio.dart';
import 'package:repair_pal/repairman_login/rm_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  /* final screens = const [
    AppointmentPage(),
    //will change to adding pics and showing previous work
    SetPhotoScreen(),
    RMProfile(userData: userData,),
    ChatsPage()
  ]; */

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //body: screens[index],
      body: FutureBuilder(
        future: getUserDataFromSharedPreferences(), // Retrieve user data
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            final userData =
                snapshot.data ?? {}; // Use an empty map as a default

            final screens = [
              AppointmentPage(),
              SetPhotoScreen(),
              RMProfile(
                userData: userData,
              ),
              ChatsPage(),
            ];

            return screens[index];
          } else {
            return CircularProgressIndicator(); // Handle loading state
          }
        },
      ),
      bottomNavigationBar: SizedBox(
          height: 65,
          child: Container(
            width: size.width * 0.7,
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
                GButton(icon: Icons.camera, text: "Add"),
                GButton(icon: Icons.person, text: "Profile"),
                GButton(icon: Icons.message, text: "Chats")
              ],
            ),
          )),
    );
  }

  Future<Map<String, dynamic>?> getUserDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userData = {
      'Fname_wd': prefs.getString('Fname_wd') ?? '',
      'Lname_wd': prefs.getString('Lname_wd') ?? '',
      'Phone_wd': prefs.getString('Phone_wd') ?? '',
      'address': prefs.getString('address') ?? '',
      'email': prefs.getString('email') ?? '',
      'picture': prefs.getString('picture') ?? '',
    };
    return userData;
  }
}
