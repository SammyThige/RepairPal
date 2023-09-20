import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? userEmail;

  void setUserEmail(String email) {
    userEmail = email;
    notifyListeners();
    print('User email set: $userEmail');
  }
}
