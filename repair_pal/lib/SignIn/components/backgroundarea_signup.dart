import 'package:flutter/material.dart';

class BackGroundAreaSignUP extends StatelessWidget {
  final Widget child;
  const BackGroundAreaSignUP({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/main_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            top: -3,
            right: -3,
            child: Transform.rotate(
              angle: -80,
              child: Image.asset(
                "assets/main_top.png",
                width: size.width * 0.35,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/main_bottom.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/login_bottom.png",
              width: size.width * 0.4,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
