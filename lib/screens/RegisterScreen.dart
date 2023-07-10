// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:singo/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  dynamic countryCode = '+977';
  dynamic country = 'नेपाल';

  DateTime? selectedDate;
  dynamic dateToSend;

  // Declaring controllers
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneNumberController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.blue,
            ),
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      final DateTime pickedDate =
          DateTime(picked.year, picked.month, picked.day);
      setState(() {
        selectedDate = pickedDate;
        dateToSend = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  Future registration() async {
    final body = jsonEncode({
      'fullname': fullNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'phone': {
        'countryCode': countryCode,
        'country': country,
        'number': phoneNumberController.text,
      },
      'dob': dateToSend,
    });
    http.Response response;
    response = await http.post(Uri.parse("$baseUrl/users/"),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      if (response.body == "1") {
        MotionToast(
                primaryColor: Colors.green,
                height: 50,
                width: 320,
                title: const Text("Success!"),
                description: const Text("Account created!"),
                icon: Icons.login_rounded)
            .show(context);
      } else {
        MotionToast(
                primaryColor: Colors.red,
                height: 50,
                width: 320,
                title: const Text("Failure!"),
                description: const Text("Couldn't create account!"),
                icon: Icons.error)
            .show(context);
      }
    } else {
      MotionToast(
              primaryColor: Colors.red,
              height: 50,
              width: 320,
              title: const Text("Failure!"),
              description: const Text("Server Error"),
              icon: Icons.error)
          .show(context);
    }
  }

  clear() {
    setState(() {
      fullNameController.clear();
      emailController.clear();
      passwordController.clear();
      phoneNumberController.clear();
      country = "नेपाल";
      countryCode = "+977";
      selectedDate = null;
    });
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
                  child: Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Image.asset('assets/icons/icon.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: fullNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email address'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Create Password',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 219, 222, 219),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: <Widget>[
                          CountryCodePicker(
                            onChanged: (CountryCode code) {
                              setState(() {
                                countryCode = code.dialCode;
                                country = code.name;
                              });
                            },
                            initialSelection: countryCode,
                            favorite: [countryCode, country],
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: TextField(
                              controller: phoneNumberController,
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          Container(
                            width: 10,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 215, 218, 215),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => _selectDate(context),
                        icon: const Icon(Icons.calendar_month),
                      ),
                      Text(
                        selectedDate == null
                            ? 'Please select a date'
                            : "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
                      ),
                      Container(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: ElevatedButton(
                      onPressed: () {
                        registration();
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        clear();
                      },
                      child: const Text(
                        'Clear',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/loginPage");
                },
                child: const Text("Already a user?"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
