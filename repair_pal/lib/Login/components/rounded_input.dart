import 'package:flutter/material.dart';
import 'package:repair_pal/Login/components/textfield_input.dart';
import 'package:repair_pal/constants.dart';

class RoundedContainer extends StatelessWidget {
  final IconData icon;
  final String hinttext;
  final ValueChanged<String> onChanged;
  const RoundedContainer({
    super.key,
    required this.icon,
    required this.hinttext,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
            icon: Icon(icon, color: kPrimaryColor),
            hintText: hinttext,
            border: InputBorder.none),
      ),
    );
  }
}
