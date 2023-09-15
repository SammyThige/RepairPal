import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../../../../test_constant.dart';
//import 'package:repair_pal/constants.dart';

class CallButton extends StatelessWidget {
  final Worker worker;
  final IconData icon;
  final String text;

  const CallButton({
    super.key,
    required this.icon,
    required this.text,
    required this.worker,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(100, 50), // button width and height
      child: ClipRect(
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Colors.orange, // button color
          child: InkWell(
            splashColor: Colors.green, // splash color
            onTap: () {
              _makePhoneCall(worker.phone);
            }, // button pressed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon), // icon
                Text(text), // text
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    try {
      await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    } catch (e) {
      // Handle errors, e.g., permission denied or other issues.
      print('Error making a phone call: $e');
    }
  }
}

class BookButton extends StatelessWidget {
  final String text;
  final VoidCallback press;

  const BookButton({
    super.key,
    required this.text,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.8,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromRGBO(218, 144, 33, 0.98),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Registration())); */
    );
  }
}
