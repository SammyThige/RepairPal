import 'package:flutter/material.dart';
import 'package:repair_pal/Login/components/textfield_input.dart';
import 'package:repair_pal/constants.dart';

class RoundedContainer extends StatelessWidget {
  final IconData icon;
  final String hinttext;
  final ValueChanged<String> onChanged;
  final TextEditingController controller; // Pass the controller here
  const RoundedContainer({
    Key? key, // Add Key? here
    required this.icon,
    required this.hinttext,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: (value) {
          // Update the controller's text when the user types
          controller.text = value;
          onChanged(value); // Call the provided onChanged callback
        },
        decoration: InputDecoration(
          icon: Icon(icon, color: kPrimaryColor),
          hintText: hinttext,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
