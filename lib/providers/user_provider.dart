import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:singo/models/User.dart';

import 'package:http/http.dart' as http;
import 'package:singo/constants.dart';

class UserProvider with ChangeNotifier {
  late User _user = User("N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A");

  User get user => _user;

  void setUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  // State for requests
  List<dynamic> _requestList = [];

  void fetchRequests() async {
    http.Response response = await http.get(
      Uri.parse("$baseUrl/performances/"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      if (response.body != "Not found") {
        var requests = json.decode(response.body);
        _requestList = requests;
        notifyListeners();
      }
    }
  }

  List<dynamic> get requestList => _requestList;
}
