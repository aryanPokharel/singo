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
    _user = newUser;
    notifyListeners();
  }

  // State for requests
  List<dynamic> _requestList = [];

  List<dynamic> get requestList => _requestList;

  void setRequest(List<dynamic> newRequests) {
    _requestList = newRequests;
    notifyListeners();
  }
}
