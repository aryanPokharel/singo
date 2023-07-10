import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:singo/components/Loading.dart';
import 'package:singo/providers/user_provider.dart';
import 'package:singo/screens/ProfileScreen.dart';
import 'package:singo/screens/RequestsScreen.dart';

import 'package:http/http.dart' as http;
import 'package:singo/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> requestList = Provider.of<UserProvider>(context).requestList;
    List<dynamic> globalList = [];

    var myUser = context.watch<UserProvider>().user;
    {
      for (var item in requestList) {
        if ((item['performed'] == true) && (item['createdBy'] != myUser.id)) {
          globalList.add(item);
        }
      }
    }

    Future getCreator(dynamic userId) async {
      dynamic createdBy;
      final body = jsonEncode({
        'userId': userId,
      });
      http.Response response;
      response = await http.post(Uri.parse("$baseUrl/users/getUser"),
          headers: {"Content-Type": "application/json"}, body: body);

      if (response.statusCode == 200) {
        if (response.body != "Not Found") {
          // print(json.decode(response.body)['fullName']);

          createdBy = json.decode(response.body)['fullName'];
        }
      }

      return json.decode(response.body)['fullName'];
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Handle drawer item tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle drawer item tap
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.book),
                if (requestList.isNotEmpty)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        requestList.length > 9
                            ? '9+'
                            : requestList.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Requests',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/requestPerformancePage");
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: requestList.isEmpty
            ? const LoadingWidget()
            : IndexedStack(
                index: _selectedIndex,
                children: [
                  ListView.builder(
                    itemCount: globalList.length,
                    itemBuilder: (context, index) {
                      var request = globalList[index];
                      // getCreator(request['createdBy']);
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
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  'By : ${getCreator(request['createdBy'])}',
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
                                const SizedBox(height: 8.0),
                                Text(
                                  'performed : ${request['performed']}',
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
                  const RequestsScreen(),
                  const ProfileScreen(),
                ],
              ),
      ),
    );
  }
}
