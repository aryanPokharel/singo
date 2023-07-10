// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:singo/constants.dart';
import 'package:singo/models/User.dart';
import 'package:singo/providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void ininState() {
    _checkNotificationEnabled() {
      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });
    }

    super.initState();
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future authentication() async {
    // await AwesomeNotifications().createNotification(
    //   content: NotificationContent(
    //       id: 1,
    //       channelKey: 'basic_channel',
    //       title: 'User Logged In',
    //       body: "You have just logged in!"),
    // );
    http.Response response;
    response = await http.post(
      Uri.parse("$baseUrl/users/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{
          'email': emailController.text,
          'password': passwordController.text,
        },
      ),
    );

    if (response.statusCode == 200) {
      if (response.body != "Not found") {
        User myUser = User(
          json.decode(response.body)["id"],
          json.decode(response.body)["fullName"],
          json.decode(response.body)["email"],
          json.decode(response.body)["password"],
          json.decode(response.body)["phone"],
          json.decode(response.body)["dob"],
          json.decode(response.body)['photo'],
        );
        context.read<UserProvider>().setUser(myUser);
        Navigator.pushNamed(context, "/homePage");
      } else {
        MotionToast(
                primaryColor: Colors.red,
                height: 50,
                width: 320,
                title: const Text("Failure!"),
                description: const Text("Invalid credentials"),
                icon: Icons.wrong_location)
            .show(context);
      }
    } else {
      MotionToast(
              primaryColor: Colors.red,
              height: 50,
              width: 320,
              title: const Text("Server error!"),
              description: const Text("No response from server"),
              icon: Icons.wrong_location)
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 150,
                  /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                  child: Image.asset('assets/icons/icon.png'),
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email address'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            TextButton(
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () {
                  authentication();
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/registerPage");
              },
              child: const Text("New user? Create account"),
            )
          ],
        ),
      ),
    ));
  }
}
