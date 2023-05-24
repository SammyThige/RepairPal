import 'package:flutter/material.dart';
import 'package:repair_pal/Login/components/textfield_input.dart';
import 'package:repair_pal/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String password;
  const RoundedPasswordField({
    super.key,
    required this.onChanged,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      obscureText: true,
      obscuringCharacter: "*",
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: password,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none),
    ));
  }
}
