import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:singo/providers/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var userName = context.watch<UserProvider>().user;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                print(userName.toJson());
              },
              child: const Text("Press"),
            )
          ],
        ),
      ),
    );
  }
}
