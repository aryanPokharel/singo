import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:singo/components/Loading.dart';
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

  dynamic toDelete;
  Future deleteMyRequest() async {
    http.Response response;
    response = await http.delete(
      Uri.parse("$baseUrl/performances/delete"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{
          'requestId': toDelete.toString(),
        },
      ),
    );

    if (response.statusCode == 200) {
      if (response.body == "1") {
        context.read<UserProvider>().fetchRequests();
      }
    }
  }

  bool _showOverlay = false;

  void _toggleOverlay() {
    setState(() {
      _showOverlay = !_showOverlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> requestList = Provider.of<UserProvider>(context).requestList;
    List<dynamic> yourList = [];
    List<dynamic> globalList = [];
    var myUser = context.watch<UserProvider>().user;

    {
      for (var item in requestList) {
        if (item['performed'] == false) {
          if (item['createdBy'] == myUser.id) {
            yourList.add(item);
          } else {
            globalList.add(item);
          }
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
            requestList.isEmpty
                ? const LoadingWidget()
                : ListView.builder(
                    itemCount: globalList.length,
                    itemBuilder: (context, index) {
                      var request = globalList[index];

                      return IntrinsicHeight(
                        child: Container(
                          // height: MediaQuery.of(context).size.height * 0.4,
                          color: const Color(0x000ffeee),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: SizedBox(
                              height: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: const Color.fromARGB(
                                          255, 185, 241, 213),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              request['title'],
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 12.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  request['createdAt'],
                                                  style: const TextStyle(
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const Text("\$"),
                                                    const SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text(
                                                      '${request['rate']}',
                                                      style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 12.0),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 70.0,
                                                  height: 70.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 3.0,
                                                    ),
                                                  ),
                                                  child: ClipOval(
                                                    child: Image.network(
                                                      'https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-profiles/avatar-2.webp',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 12.0),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        '@ramBahadur',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children:
                                                                List.generate(
                                                              5,
                                                              (_) => const Icon(
                                                                Icons.star,
                                                                size: 12.0,
                                                                color: Color(
                                                                    0xFF1B7B2C),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 6.0),
                                                          Row(
                                                            children: [
                                                              const SizedBox(
                                                                  width: 8.0),
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () {},
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  foregroundColor:
                                                                      Colors
                                                                          .black,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  shape:
                                                                      const CircleBorder(),
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                ),
                                                                child: const Icon(
                                                                    Icons
                                                                        .comment),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16.0),
                                            const Divider(),
                                            const SizedBox(height: 8.0),
                                            Text(
                                              request['description'],
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            const SizedBox(height: 12.0),
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.access_time),
                                                  SizedBox(width: 8.0),
                                                  Text(
                                                    'Bid',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                : Stack(
                    children: [
                      ListView.builder(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            Row(
                                              children: [
                                                IconButton(
                                                  color: Colors.blue,
                                                  icon: const Icon(Icons.edit),
                                                  onPressed: () {
                                                    context
                                                        .read<UserProvider>()
                                                        .setRequestToEdit(
                                                            request['_id']);

                                                    // _toggleOverlay();
                                                    Navigator.pushNamed(context,
                                                        '/editRequestScreen');
                                                  },
                                                ),
                                                IconButton(
                                                  color: Colors.red,
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  onPressed: () {
                                                    _toggleOverlay();

                                                    setState(() {
                                                      toDelete = request['_id'];
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          request['description'],
                                          style:
                                              const TextStyle(fontSize: 16.0),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          'Rs.${request['rate']}',
                                          style:
                                              const TextStyle(fontSize: 16.0),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          'Created: ${request['createdAt']}',
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            color:
                                                Color.fromARGB(255, 67, 63, 63),
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
                      if (_showOverlay)
                        GestureDetector(
                          onTap: _toggleOverlay,
                          child: Container(
                            color: Colors.black.withOpacity(0.5),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.fromLTRB(0, 200, 0, 200),
                            child: Card(
                              color: const Color.fromARGB(255, 212, 216, 219),
                              elevation: 4,
                              margin: const EdgeInsets.all(16.0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Deleting Request!',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    const Text(
                                      'Are you sure?',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green),
                                          onPressed: () {
                                            deleteMyRequest();
                                            _toggleOverlay();
                                          },
                                          child: const Text('Yes'),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          onPressed: () {
                                            _toggleOverlay();
                                          },
                                          child: const Text('No'),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
