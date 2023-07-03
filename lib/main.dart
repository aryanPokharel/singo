import 'package:flutter/material.dart';
import 'package:singo/screens/LoginScreen.dart';
import 'package:singo/screens/RegisterScreen.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/registerPage',
      routes: {
        '/loginPage': (context) => const LoginScreen(),
        '/registerPage': (context) => const RegisterScreen(),
      },
    ),
  );
}
