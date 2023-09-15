import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repair_pal/HomePage/homepage.dart';
import 'package:repair_pal/Login/components/rounded_input.dart';
import 'package:repair_pal/Login/components/rounded_password.dart';
import 'package:repair_pal/Login/components/roundedbutton.dart';
import 'package:repair_pal/Login/components/signupquestion.dart';
import 'package:repair_pal/Login/login_screen.dart';
import 'package:repair_pal/SignIn/components/backgroundarea_signup.dart';
import 'package:repair_pal/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:repair_pal/repairman_login/bottomnav.dart';

// ignore: constant_identifier_names
enum UserRole { HomeOwner, RepairPerson }

class SignUP extends StatelessWidget {
  const SignUP({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SignUpBody());
  }
}

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  String _selectedSellerDescription = 'Electrician';
  bool _showSellerFields = false;
  late ScaffoldMessengerState scaffoldMessenger;
  //TextEditingController _sellerDescriptionController = TextEditingController();
  //TextEditingController _sellerLocationController = TextEditingController();
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cfrmpassword = TextEditingController();
  TextEditingController address = TextEditingController();

  UserRole _selectedRole = UserRole.HomeOwner;

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
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
          Expanded(
            child: SingleChildScrollView(
              //height: MediaQuery.of(context).size.height,
              child: Column(children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: Column(
                    children: [
                      DropdownButtonFormField<UserRole>(
                        decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                        ),
                        value: _selectedRole,
                        onChanged: (UserRole? newValue) {
                          setState(() {
                            _selectedRole = newValue!;
                            _showSellerFields =
                                _selectedRole == UserRole.RepairPerson;
                          });
                        },
                        items: const [
                          DropdownMenuItem(
                            value: UserRole.HomeOwner,
                            child: Text('Customer'),
                          ),
                          DropdownMenuItem(
                            value: UserRole.RepairPerson,
                            child: Text('Seller'),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: _showSellerFields,
                        child: Column(
                          children: [
                            DropdownButtonFormField<String>(
                              value: _selectedSellerDescription,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedSellerDescription = newValue!;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Seller Designation',
                              ),
                              items: <String>[
                                'Electrician',
                                'Plumber',
                                'Painter',
                                'Roofer',
                                'Carpenter',
                                'Mason',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                RoundedContainer(
                  icon: Icons.person_2,
                  hinttext: "First Name",
                  onChanged: (value) {
                    // The controller's text will be updated automatically
                  },
                  controller:
                      fName, // Assign the appropriate TextEditingController
                ),
                RoundedContainer(
                    controller: lName,
                    hinttext: "Last Name",
                    onChanged: (value) {},
                    icon: Icons.person_3),
                RoundedContainer(
                    controller: email,
                    hinttext: "Email",
                    onChanged: (value) {},
                    icon: Icons.email),
                RoundedContainer(
                    controller: phone,
                    hinttext: "Phone Number",
                    onChanged: (value) {},
                    icon: Icons.phone),
                RoundedContainer(
                    controller: address,
                    hinttext: "Address",
                    onChanged: (value) {},
                    icon: Icons.location_city),
                RoundedPasswordField(
                  hintText: 'Password', // Pass the hint text using hintText
                  onChanged: (value) {
                    // The controller's text will be updated automatically
                  },
                  controller:
                      passwordController, // Assign the appropriate TextEditingController
                ),
                RoundedPasswordField(
                  onChanged: (value) {},
                  hintText: 'Confirm Password',
                  controller: cfrmpassword,
                ),
                RoundedButton(
                    text: "SIGN UP",
                    press: () {
                      SignUpFunction();
                    }),
                const SizedBox(
                  height: 15,
                ),
                SignUpQuestion(
                  login: false,
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginPage();
                    }));
                  },
                ),
                const SizedBox(
                  height: 30,
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void SignUpFunction() {
    if (fName.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Provide First Name"),
      );

      return;
    } else if (lName.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Provide Second Name"),
      );
      return;
    } else if (email.text.isEmpty) {
      //call sigin function
      scaffoldMessenger.showSnackBar(
        mySnackBar("Provide Email"),
      );
      return;
    } else if (phone.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Provide Phone Number"),
      );
      return;
    } else if (address.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Provide Address"),
      );
      return;
    } else if (passwordController.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Provide Password"),
      );
      return;
    } else if (cfrmpassword.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Please re-type the password"),
      );
      return;
    } else if (cfrmpassword.text != passwordController.text) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Password does not match"),
      );
      return;
    } else {
      // Check the selected role and update the URL accordingly
      final String signupURL = _selectedRole == UserRole.RepairPerson
          ? "https://sam-thige.000webhostapp.com/RepairPal/scripts/repairpal_signup_handyman.php" // Seller URL
          : "https://sam-thige.000webhostapp.com/RepairPal/scripts/repairpal_signup_homeowner.php"; // Customer URL

      if (_selectedRole == UserRole.RepairPerson) {
        // User is a Seller, include the _selectedSellerDescription
        signUp(
          fName.text,
          lName.text,
          email.text,
          phone.text,
          address.text,
          passwordController.text,
          _selectedSellerDescription,
          signupURL,
        );
      } else {
        // User is a HomeOwner, exclude the _selectedSellerDescription
        signUp(
          fName.text,
          lName.text,
          email.text,
          phone.text,
          address.text,
          passwordController.text,
          null, // or ''
          signupURL,
        );
      }
    }
  }

  // Define a function to handle navigation
  void navigateToHomepage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
    );
  }

// Your signUp function
  // Your signUp function
  Future<void> signUp(String Fname, Lname, Email, Phone, Address, Password,
      sellerDescription, signupURL) async {
    BuildContext currentContext = context;

    DialogBuilder(context).showLoadingIndicator(
      "Please wait as we register you",
      "Authentication",
    );

    Map data = {
      'firstNamemap': Fname,
      'secondNamemap': Lname,
      'emailmap': Email,
      'phonemap': Phone,
      'addressmap': Address,
      'passwordmap': Password,
      'sellerDescriptionmap':
          sellerDescription ?? '', // Add null check and provide a default value
    };

    try {
      var response = await http.post(
        Uri.parse(signupURL), // Use the provided URL
        body: data,
      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        print("Response Body: ${response.body}");

        if (jsonResponse != null) {
          setState(() {
            DialogBuilder(context).hideOpenDialog();
          });

          int isRegistered = jsonResponse['code'];
          if (isRegistered == 1) {
            if (_selectedRole == UserRole.HomeOwner) {
              // Customer
              Navigator.push(
                currentContext,
                MaterialPageRoute(
                    builder: (BuildContext context) => const HomePage()),
              );
            } else if (_selectedRole == UserRole.RepairPerson) {
              // Handyman
              Navigator.push(
                currentContext,
                MaterialPageRoute(builder: (BuildContext context) => RMPage()),
              );
            }
            // Correct password, move to dashboard
            navigateToHomepage(context);
          } else {
            // Wrong password, use SnackBar to Show
            ScaffoldMessenger.of(context).showSnackBar(
              mySnackBar("Wrong Email or Password"),
            );
          }
        } else {
          setState(() {
            DialogBuilder(context).hideOpenDialog();
          });

          // Handle empty response
          print("Empty response received");
        }
      } else {
        setState(() {
          DialogBuilder(context).hideOpenDialog();
        });

        // Handle HTTP error responses
        print("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        DialogBuilder(context).hideOpenDialog();
      });

      // Handle exceptions
      print("Error: $e");
    }
  }
}
