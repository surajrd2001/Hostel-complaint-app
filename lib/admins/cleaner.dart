import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hostel_app/admins/cleanerdataread.dart';

import 'package:hostel_app/login.dart';

class CleanerHome extends StatefulWidget {
  const CleanerHome({Key? key}) : super(key: key);
  @override
  State<CleanerHome> createState() => _CleanerHome();
}

class _CleanerHome extends State<CleanerHome> {
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
            title: Text("Cleaner"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 1, 205, 215),
          ),
          body: Column(
            children: [Expanded(child: Cleanermainpage())],
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
