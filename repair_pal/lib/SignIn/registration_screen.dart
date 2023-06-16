import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repair_pal/Login/components/rounded_input.dart';
import 'package:repair_pal/Login/components/rounded_password.dart';
import 'package:repair_pal/Login/components/roundedbutton.dart';
import 'package:repair_pal/Login/components/signupquestion.dart';
import 'package:repair_pal/Login/login_screen.dart';
import 'package:repair_pal/SignIn/components/backgroundarea_signup.dart';
import 'package:repair_pal/constants.dart';

class SignUP extends StatelessWidget {
  const SignUP({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SignUpBody());
  }
}

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BackGroundAreaSignUP(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Hello! Register to get started",
            style: GoogleFonts.lato(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: kPrimaryColor,
            ),
          ),
          SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                RoundedContainer(
                    hinttext: "First Name",
                    onChanged: (value) {},
                    icon: Icons.person_2),
                RoundedContainer(
                    hinttext: "Last Name",
                    onChanged: (value) {},
                    icon: Icons.person_3),
                RoundedContainer(
                    hinttext: "Email",
                    onChanged: (value) {},
                    icon: Icons.email),
                RoundedContainer(
                    hinttext: "Phone Number",
                    onChanged: (value) {},
                    icon: Icons.phone),
                RoundedPasswordField(
                    onChanged: (value) {}, password: 'Password'),
                RoundedPasswordField(
                    onChanged: (value) {}, password: 'Confirm Password'),
                RoundedButton(text: "SIGN UP", press: () {}),
                SignUpQuestion(
                  login: false,
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginPage();
                    }));
                  },
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
