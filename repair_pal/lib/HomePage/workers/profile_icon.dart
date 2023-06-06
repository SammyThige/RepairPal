import 'package:flutter/material.dart';
import 'package:repair_pal/constants.dart';

class Profile extends StatelessWidget {
  final ImageProvider icon;
  //final VoidCallback onPressed;
  const Profile({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: 85,
      child: CircleAvatar(
        radius: 48, // Image radius
        backgroundImage: icon,
      ),
    );
  }
}
