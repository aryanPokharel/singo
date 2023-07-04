import 'package:flutter/material.dart';
import 'package:singo/screens/HomeScreen.dart';
import 'package:singo/screens/LoginScreen.dart';
import 'package:singo/screens/RegisterScreen.dart';
import 'package:singo/screens/SplashScreen.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splashScreen',
      routes: {
        '/splashScreen': (context) => const SplashScreen(),
        '/loginPage': (context) => const LoginScreen(),
        '/registerPage': (context) => const RegisterScreen(),
        '/homePage': (context) => const HomeScreen()
      },
    ),
  );
}
