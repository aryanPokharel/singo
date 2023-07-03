import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:http/http.dart' as http;
import 'package:singo/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  dynamic countryCode = '+977';
  dynamic country = 'NEP';
  String? phoneNumber;

  DateTime? selectedDate;

  // Declaring controllers
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();

  var phoneController = TextEditingController();
  var dobController = TextEditingController();

  var passwordController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
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
        'number': phoneNumber,
      },
      'dob': selectedDate.toString(),
    });
    http.Response response;
    response = await http.post(Uri.parse("$baseUrl/users/"),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      print("Connected");
    }
  }

  clear() {
    setState(() {
      fullNameController.clear();
      emailController.clear();
      passwordController.clear();
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
                          borderRadius: BorderRadius.circular(50.0)),
                      child: Image.asset('assets/icons/icon.png')),
                ),
              ),
              const Text("Register"),
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
                      hintText: 'Enter valid email id as abc@gmail.com'),
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
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 188, 216, 189),
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
                            initialSelection: 'नेपाल',
                            favorite: const ['+977', 'नेपाल'],
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                              ),
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                setState(() {
                                  phoneNumber = value;
                                });
                              },
                            ),
                          ),
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
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 188, 216, 189),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => _selectDate(context),
                          icon: const Icon(Icons.calendar_month)),
                      Text(
                        selectedDate == null
                            ? 'Please select a date'
                            : selectedDate.toString(),
                      )
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
                        style: TextStyle(color: Colors.white, fontSize: 25),
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
                        style: TextStyle(color: Colors.white, fontSize: 25),
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
