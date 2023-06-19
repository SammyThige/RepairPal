import 'package:flutter/material.dart';
import 'package:repair_pal/HomePage/homepage.dart';
import 'package:repair_pal/Login/components/background_area.dart';
import 'package:flutter_svg/svg.dart';
import 'package:repair_pal/Login/components/rounded_input.dart';
import 'package:repair_pal/Login/components/rounded_password.dart';
import 'package:repair_pal/Login/components/roundedbutton.dart';
import 'package:repair_pal/Login/components/signupquestion.dart';
import 'package:repair_pal/SignIn/registration_screen.dart';
//import 'package:repair_pal/test2.dart';

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

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
          RoundedContainer(
            hinttext: "Email",
            onChanged: (value) {},
            icon: Icons.person,
          ),
          RoundedPasswordField(
            onChanged: (value) {},
            password: 'Password',
          ),
          RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
              }),
          SizedBox(
            height: size.height * 0.03,
          ),
          SignUpQuestion(
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SignUP();
              }));
            },
          )
        ],
      ),
    );
  }
}
