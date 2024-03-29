import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:singo/providers/user_provider.dart';
import 'package:singo/screens/ClientProfileScreen.dart';
import 'package:singo/screens/EditRequestScreen.dart';
import 'package:singo/screens/HomeScreen.dart';
import 'package:singo/screens/LoginScreen.dart';
import 'package:singo/screens/RegisterScreen.dart';
import 'package:singo/screens/RequestPerformanceScreen.dart';
import 'package:singo/screens/SplashScreen.dart';

import 'package:awesome_notifications/awesome_notifications.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize('resource://drawable/icon', [
    NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Colors.green,
        importance: NotificationImportance.High,
        ledColor: Colors.white,
        channelShowBadge: true)
  ]);
  runApp(
    ChangeNotifierProvider<UserProvider>(
      create: (_) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/loginPage',
        routes: {
          '/splashScreen': (context) => const SplashScreen(),
          '/loginPage': (context) => const LoginScreen(),
          '/registerPage': (context) => const RegisterScreen(),
          '/homePage': (context) => const HomeScreen(),
          '/editRequestScreen': (context) => const EditRequestScreen(),
          '/requestPerformancePage': (context) =>
              const RequestPerformanceScreen(),
          '/clientProfilePage': (context) => const ClientProfileScreen(),
        },
      ),
    ),
  );
}
