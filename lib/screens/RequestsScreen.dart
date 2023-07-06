import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:singo/providers/user_provider.dart';

import 'package:http/http.dart' as http;
import 'package:singo/constants.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().fetchRequests();
  }

  Future deleteMyRequest(dynamic toDeleteId) async {
    http.Response response;
    response = await http.delete(
      Uri.parse("$baseUrl/performances/delete"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{
          'requestId': toDeleteId.toString(),
        },
      ),
    );

    if (response.statusCode == 200) {
      if (response.body == "1") {
        context.read<UserProvider>().fetchRequests();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> requestList = Provider.of<UserProvider>(context).requestList;
    List<dynamic> yourList = [];
    List<dynamic> globalList = [];
    var myUser = context.watch<UserProvider>().user;
    {
      for (var item in requestList) {
        if (item['createdBy'] == myUser.id) {
          yourList.add(item);
        } else {
          globalList.add(item);
        }
      }
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 4,
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Global",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Your",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: globalList.length,
              itemBuilder: (context, index) {
                var request = globalList[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 164, 199, 216),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    constraints: const BoxConstraints(maxWidth: 540.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            request['title'],
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            request['description'],
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'By : ${request['createdBy']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Rs.${request['rate']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Created : ${request['createdAt']}',
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Color.fromARGB(255, 67, 63, 63),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            yourList.isEmpty
                ? const Center(
                    child: Text("Looks Empty!"),
                  )
                : ListView.builder(
                    itemCount: yourList.length,
                    itemBuilder: (context, index) {
                      var request = yourList[index];

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.lime,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              constraints:
                                  const BoxConstraints(maxWidth: 540.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          request['title'],
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          color: Colors.red,
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            deleteMyRequest(request['_id']);
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      request['description'],
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'By: ${request['createdBy']}',
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      'Rs.${request['rate']}',
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      'Created: ${request['createdAt']}',
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: Color.fromARGB(255, 67, 63, 63),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
