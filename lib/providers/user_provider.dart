import 'dart:convert';
import 'dart:async';
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

  // state for working with requests
  dynamic _requestToEdit;
  dynamic get requestToEdit => _requestToEdit;
  void setRequestToEdit(dynamic requestId) {
    _requestToEdit = requestId;
    notifyListeners();
  }

  // Timer to periodically call fetchRequests
  Timer? _timer;

  void startFetchingRequestsPeriodically() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      fetchRequests();
    });
  }

  // Call startFetchingRequestsPeriodically in your desired location, such as in the constructor of the UserProvider class
  UserProvider() {
    startFetchingRequestsPeriodically();
  }

  // Remember to cancel the timer when the UserProvider is disposed
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
