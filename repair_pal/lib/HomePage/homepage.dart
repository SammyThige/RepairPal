import 'package:flutter/material.dart';
import 'package:repair_pal/AppointmentPage/appointment.dart';
import 'package:repair_pal/ChatsPage/chats.dart';
import 'package:repair_pal/HomePage/components/appbar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:repair_pal/UserProfile/testprofile.dart';
import 'package:repair_pal/constants.dart';
import 'package:repair_pal/Login/components/background_body.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  //late final String logginuser;
  //final Prefs _prefs = Prefs();
  @override
  Widget build(BuildContext context) {
    /* _prefs.getStringValuesSF('fname').then((firstname) => {
          setState(() {
            logginuser = firstname!;
          })
        }); */
    return Scaffold(
      appBar: AppToolBar(),
      body: Body(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
              HomeDashPage(),
              AppointmentPage(),
              MyProfile(
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
              GButton(icon: Icons.message, text: "Chats"),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> getUserDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userData = {
      'firstName_cl': prefs.getString('firstName_cl') ?? '',
      'lastName_cl': prefs.getString('lastName_cl') ?? '',
      'phone_cl': prefs.getString('phone_cl') ?? '',
      'location': prefs.getString('location') ?? '',
      'email': prefs.getString('email') ?? '',
      'picture': prefs.getString('picture') ?? '',
    };
    return userData;
  }
}
