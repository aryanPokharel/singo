import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:singo/constants.dart';
import 'package:singo/providers/user_provider.dart';

class RequestPerformanceScreen extends StatefulWidget {
  const RequestPerformanceScreen({super.key});

  @override
  _RequestPerformanceScreenState createState() =>
      _RequestPerformanceScreenState();
}

class _RequestPerformanceScreenState extends State<RequestPerformanceScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phone = '';
  final String _address = '';

  // Creating controllers for the form fields
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var rateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var myUser = context.watch<UserProvider>().user;
    void _submitForm() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        http.Response response;
        response = await http.post(
          Uri.parse("$baseUrl/performances/post"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
            <String, String>{
              'createdBy': myUser.id,
              'title': titleController.text,
              'description': descriptionController.text,
              'rate': rateController.text,
            },
          ),
        );

        if (response.statusCode == 200) {
          if (response.body != "Not found") {
            // ignore: use_build_context_synchronously
            MotionToast(
                    primaryColor: Colors.green,
                    height: 50,
                    width: 320,
                    title: const Text("Success!"),
                    description: const Text("Request posted"),
                    icon: Icons.wrong_location)
                .show(context);
          } else {
            // ignore: use_build_context_synchronously
            MotionToast(
                    primaryColor: Colors.red,
                    height: 50,
                    width: 320,
                    title: const Text("Failure!"),
                    description: const Text("Request couldn't be posted"),
                    icon: Icons.wrong_location)
                .show(context);
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Form Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Song Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please describe how the performance should be like';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                controller: rateController,
                decoration: const InputDecoration(
                  labelText: 'Rate (Rs)',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a desired rate';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = value!;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
