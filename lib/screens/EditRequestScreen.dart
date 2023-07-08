import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

import 'package:singo/providers/user_provider.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class EditRequestScreen extends StatefulWidget {
  const EditRequestScreen({super.key});

  @override
  State<EditRequestScreen> createState() => _EditRequestScreenState();
}

class _EditRequestScreenState extends State<EditRequestScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var rateController = TextEditingController();
  var requestToEdit;

  // Initial Values
  var titleValue = 'N/A';
  var descriptionValue = 'N/A';
  var rateValue = 'N/A';

  var dataReceived = false;

  @override
  void initState() {
    super.initState();
    requestToEdit = context.read<UserProvider>().requestToEdit;

    fetchRequest();
  }

  Future fetchRequest() async {
    http.Response response;
    response = await http.post(
      Uri.parse("$baseUrl/performances/getById"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{
          'requestId': requestToEdit,
        },
      ),
    );

    if (response.statusCode == 200) {
      if (response.body != "Not found") {
        setState(() {
          dataReceived = true;
          var myRequest = json.decode(response.body);
          titleValue = myRequest[0]['title'];
          descriptionValue = myRequest[0]['description'];
          rateValue = myRequest[0]['rate'];
        });
      } else {
        // ignore: use_build_context_synchronously
        MotionToast(
                primaryColor: Colors.red,
                height: 50,
                width: 320,
                title: const Text("Failure!"),
                description: const Text("Could not make changes!"),
                icon: Icons.wrong_location)
            .show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var requestToEdit = context.watch<UserProvider>().requestToEdit;

    Future uploadChanges() async {
      http.Response response;
      response = await http.post(
        Uri.parse("$baseUrl/performances/edit"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          <String, String>{
            'requestId': requestToEdit,
            'title': titleController.text,
            'description': descriptionController.text,
            'rate': rateController.text
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
                  description: const Text("Changes saved!"),
                  icon: Icons.wrong_location)
              .show(context);
        } else {
          // ignore: use_build_context_synchronously
          MotionToast(
                  primaryColor: Colors.red,
                  height: 50,
                  width: 320,
                  title: const Text("Failure!"),
                  description: const Text("Could not make changes!"),
                  icon: Icons.wrong_location)
              .show(context);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Make the changes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: !dataReceived
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Fetching Data'),
                  SizedBox(height: 16.0),
                  LinearProgressIndicator(),
                ],
              )
            : Form(
                child: Column(
                  children: <Widget>[
                    Text('Title : $dataReceived'),
                    TextFormField(
                      initialValue: titleValue,
                      // controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Song Title',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: descriptionValue,
                      // controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please describe how the performance should be like';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: rateValue,
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
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: uploadChanges,
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
