import 'package:flutter/material.dart';
import 'package:repair_pal/HomePage/homepage.dart';
//import 'package:repair_pal/HomePage/workers/worker_listview.dart';
import 'package:repair_pal/Login/components/background_area.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:repair_pal/Login/components/rounded_input.dart';
import 'package:repair_pal/Login/components/rounded_password.dart';
import 'package:repair_pal/Login/components/roundedbutton.dart';
import 'package:repair_pal/Login/components/signupquestion.dart';
import 'package:repair_pal/SignIn/registration_screen.dart';
import 'package:repair_pal/constants.dart';
import 'package:repair_pal/repairman_login/bottomnav.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Background extends StatefulWidget {
  const Background({
    super.key,
  });

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  var _prefs = Prefs();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late ScaffoldMessengerState scaffoldMessenger;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackGroundArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "WELCOME BACK",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          SvgPicture.asset(
            "assets/plumber.svg",
            height: size.height * 0.35,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          ToggleSwitch(
            initialLabelIndex: selectedIndex,
            minWidth: 120,
            minHeight: 50,
            cornerRadius: 10,
            fontSize: 15,
            //iconSize: 25,
            activeBgColors: [
              [Colors.orangeAccent],
              [kPrimaryColor],
            ],
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.black26,
            inactiveFgColor: Colors.white,
            totalSwitches: 2,
            labels: ['HomeOwner', 'Handyman'],
            //icons: [Icons.male, Icons.female],
            onToggle: (index) {
              setState(() {
                selectedIndex = index!; // Update the selected index
              });
            },
          ),
          RoundedContainer(
            controller: emailController,
            hinttext: "Email",
            onChanged: (value) {},
            icon: Icons.person,
          ),
          RoundedPasswordField(
            controller: passwordController,
            onChanged: (value) {},
            hintText: 'Password',
          ),
          RoundedButton(
            text: selectedIndex == 0 ? "LOGIN" : "LOGIN",
            press: () {
              loginFunction();
              /*  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return selectedIndex == 0 ? const HomePage() : RMPage();
              })); */
            },
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          SignUpQuestion(
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SignUP();
              }));
            },
          )
        ],
      ),
    );
  }

  void loginFunction() {
    if (passwordController.text.isEmpty && emailController.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Provide Email and Password"),
      );

      return;
    } else if (passwordController.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Provide Password"),
      );
      return;
    } else if (emailController.text.isEmpty) {
      //call sigin function
      scaffoldMessenger.showSnackBar(
        mySnackBar("Provide Email"),
      );
      return;
    } else {
      signIn(emailController.text, passwordController.text, selectedIndex);
    }
  }

  Future<void> signIn(String email, password, int selectedIndex) async {
    // Capture the context outside of the async function
    BuildContext currentContext = context;

    DialogBuilder(currentContext).showLoadingIndicator(
      "Please wait as we authenticate you",
      "Authentication",
    );

    String url = "";
    if (selectedIndex == 0) {
      // HomeOwner login
      url =
          "https://sam-thige.000webhostapp.com/RepairPal/scripts/test_login.php";
    } else if (selectedIndex == 1) {
      // Handyman login
      url =
          "https://sam-thige.000webhostapp.com/RepairPal/scripts/repairpal_login_handyman.php";
    }

    Map data = {'emailmap': email, 'passwordmap': password};
    dynamic jsonResponse;
    try {
      var response = await http.post(
        Uri.parse(url),
        body: data,
      );

      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {
          setState(() {
            DialogBuilder(currentContext).hideOpenDialog();
          });
          int isRegistered = jsonResponse['code'];
          if (isRegistered == 1) {
            // Use shared preferences to store username and firstname
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('firstName_cl', jsonResponse['firstName_cl'] ?? '');
            prefs.setString('lastName_cl', jsonResponse['lastName_cl'] ?? '');
            prefs.setString('phone_cl', jsonResponse['phone_cl'] ?? '');
            prefs.setString('location', jsonResponse['location'] ?? '');
            prefs.setString('email', jsonResponse['email'] ?? '');

            // Store the 'picture' field with a null check
            prefs.setString('picture', jsonResponse['picture'] ?? '');

            // Correct password, navigate to the appropriate page
            if (selectedIndex == 0) {
              // HomeOwner
              Navigator.push(
                currentContext,
                MaterialPageRoute(
                    builder: (BuildContext context) => const HomePage()),
              );
            } else if (selectedIndex == 1) {
              // Handyman
              Navigator.push(
                currentContext,
                MaterialPageRoute(builder: (BuildContext context) => RMPage()),
              );
            }
          } else {
            // Wrong username or password, use SnackBar to Show
            ScaffoldMessenger.of(currentContext).showSnackBar(
              mySnackBar("Wrong Username or Password"),
            );
          }
        } else {
          // Handle empty response
          ScaffoldMessenger.of(currentContext).showSnackBar(
            mySnackBar("Empty response received"),
          );
        }
      } else {
        // Handle HTTP error responses
        ScaffoldMessenger.of(currentContext).showSnackBar(
          mySnackBar("HTTP Error: ${response.statusCode}"),
        );
      }
    } catch (e) {
      // Handle exceptions
      ScaffoldMessenger.of(currentContext).showSnackBar(
        mySnackBar("Error: $e"),
      );
    }
  }
}
