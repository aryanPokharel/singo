import 'package:flutter/material.dart';
import 'package:singo/models/User.dart';

class UserProvider with ChangeNotifier {
  late User _user = User(
    "N/A",
    "N/A",
    "N/A",
    "N/A",
    "N/A",
    "N/A",
  );

  User get user => _user;

  void setUser(User newUser) {
    _user =
        newUser; // Use the class field (_user) instead of the parameter (user)
    notifyListeners();
  }
}
