import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:repair_pal/HomePage/homepage.dart';
import 'package:repair_pal/HomePage/workers/worker_profile/components/booking_page.dart';

class BookedAppointment extends StatelessWidget {
  const BookedAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Lottie.asset("assets/tick.json"),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Successfully Booked',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Button(
                width: 120,
                title: 'Back to Home Page',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                disable: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
