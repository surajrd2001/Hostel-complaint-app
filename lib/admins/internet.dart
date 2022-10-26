import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hostel_app/admins/cleanerdataread.dart';
import 'package:hostel_app/admins/internetdataread.dart';

import 'package:hostel_app/login.dart';

class InternetHome extends StatefulWidget {
  const InternetHome({Key? key}) : super(key: key);
  @override
  State<InternetHome> createState() => _InternetHome();
}

class _InternetHome extends State<InternetHome> {
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon:
                  Icon(Icons.logout, color: Color.fromARGB(255, 246, 243, 243)),
              onPressed: () async => {
                await FirebaseAuth.instance.signOut(),
                await storage.delete(key: "uid"),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyLogin()),
                )
              },
            ),
            actions: [
              Padding(padding: EdgeInsets.only(left: 50)),
              Icon(Icons.verified_user),
            ],
            title: Text("Internet Provider"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 1, 205, 215),
          ),
          body: Column(
            children: [Expanded(child: Internetmainpage())],
          )),

      // child:
      // ListView.builder(
      //     itemCount: 3,
      //     itemBuilder: (context, index) {
      //       return ListTile(
      //         title: Text('name'),
      //       );
      //     })
    );
  }
}
