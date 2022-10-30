import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hostel_app/home.dart';
import 'package:hostel_app/login.dart';
import 'package:hostel_app/readData.dart';
import 'package:hostel_app/adminmainpage.dart';

class adminHome extends StatefulWidget {
  const adminHome({Key? key}) : super(key: key);
  @override
  State<adminHome> createState() => _adminHome();
}

class _adminHome extends State<adminHome> {
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
            title: Text("All Complaints"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 1, 205, 215),
          ),
          body: Column(
            children: [Expanded(child: adminmainpage())],
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
