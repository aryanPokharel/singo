import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class MyToast extends StatefulWidget {
  const MyToast({Key? key}) : super(key: key);

  @override
  State<MyToast> createState() => _MyToastState();
}

class _MyToastState extends State<MyToast> {
  void showMotionToast() {
    MotionToast(
      primaryColor: Colors.green,
      height: 50,
      width: 320,
      title: const Text("Success!"),
      description: const Text("Request posted"),
      icon: Icons.location_city,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed:
            showMotionToast, // Trigger the toast when the button is pressed
        child: const Text('Show Toast'),
      ),
    );
  }
}
