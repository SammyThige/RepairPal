import 'package:flutter/material.dart';
//import 'package:repair_pal/constants.dart';

class CallButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  const CallButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed});

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
            onTap: () {}, // button pressed
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
}

/* Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: kPrimaryColor,
      ),
      child: Icon(icon, color: Colors.orange),
    ); */