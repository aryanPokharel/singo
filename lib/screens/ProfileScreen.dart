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
    var myUser = context.watch<UserProvider>().user;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 203, 200, 200),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(myUser.photo),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                myUser.fullName.toString(),
                style: const TextStyle(
                  fontFamily: 'Sacramento',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              const Text(
                "Some Subtitle : ",
                style: TextStyle(fontSize: 15, fontFamily: 'EBGaramond'),
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 208, 192, 45)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/loginPage');
                    },
                    child: const Text("Log Out"),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {},
                    child: const Text("Delete Account"),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
                width: 150,
                child: Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
              Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: const Color.fromARGB(255, 225, 215, 215),
                child: ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(
                      '+${myUser.phone['countryCode'].toString()} ${myUser.phone['number'].toString()}'),
                ),
              ),
              Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: const Color.fromARGB(255, 240, 223, 223),
                child: ListTile(
                  leading: const Icon(Icons.mail),
                  title: Text(myUser.email.toString()),
                ),
              ),
              Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: const Color.fromARGB(255, 210, 178, 178),
                child: ListTile(
                  leading: const Icon(Icons.cake),
                  title: Text(myUser.dob.toString()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
