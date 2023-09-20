import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:repair_pal/HomePage/workers/worker_profile/components/booking_page.dart';
import 'package:repair_pal/HomePage/workers/worker_profile/components/call_button.dart';
import 'package:repair_pal/HomePage/workers/worker_profile/components/image_slider.dart';
import 'package:repair_pal/Login/components/roundedbutton.dart';
import 'package:repair_pal/test_constant.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkerProfile extends StatelessWidget {
  final Worker worker;

  const WorkerProfile({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[
                Color.fromRGBO(111, 31, 148, 1),
                Color.fromRGBO(218, 144, 33, 0.98)
              ],
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter)),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        splashColor: Colors.red,
                        /* onTap: () {
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WorkerProfile()));
                        }, */
                        child: Icon(
                          Icons.arrow_back_outlined,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "My\nProfile",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontFamily: "Nunito"),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: height * 0.4,
                    child: LayoutBuilder(builder: (context, constraints) {
                      double innerHeight = constraints.maxHeight;
                      double innerWidth = constraints.maxWidth;
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: innerHeight * 0.65,
                              width: innerWidth,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 70),
                                  Text(
                                    '${worker.firstName} ${worker.lastName}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nunito',
                                      fontSize: 30,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CallButton(
                                        icon: Icons.call,
                                        text: 'Call',
                                        worker: worker,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Container(
                                          height: 40,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.grey),
                                        ),
                                      ),
                                      CallButton(
                                        worker: worker,
                                        icon: Icons.message,
                                        //onPressed: () {},
                                        text: 'Chat',
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                child: Image.asset(
                                  "assets/profile.png",
                                  width: innerWidth * 0.45,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  SizedBox(height: 25),
                  Container(
                    height: height * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Previous Work',
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Nunito',
                              color: Colors.black,
                            ),
                          ),
                          const Divider(
                            thickness: 3,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ComplicatedImageDemo(),
                          //RoundedButton(text: "BOOK NOW", press: () {}),
                        ],
                      ),
                    ),
                  ),
                  BookButton(
                      text: "BOOK NOW",
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingPage(
                                      workerEmail: worker.email,
                                      workerFname: worker.firstName,
                                      workerLname: worker.lastName,
                                    )));
                      })
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
