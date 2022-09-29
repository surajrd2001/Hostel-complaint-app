import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hostel_app/complaint.dart';
import 'package:hostel_app/home.dart';
import 'package:hostel_app/login.dart';
import 'package:hostel_app/register.dart';

import 'package:hostel_app/status.dart';
import 'package:hostel_app/upcoming.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final storage = new FlutterSecureStorage();

  Future<bool> checkLoginStatus() async {
    String? value = await storage.read(key: "uid");
    if (value == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for Errors
          if (snapshot.hasError) {
            print("Something Went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            //here are the conditions for login without the email auth for each time when we logeed in
            home: FutureBuilder(
                future: checkLoginStatus(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.data == false) {
                    return MyLogin();
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        color: Colors.white,
                        child: Center(child: CircularProgressIndicator()));
                  }
                  return MyHome();
                }),
            routes: {
              'home': (context) => MyHome(),
              'register': (context) => MyRegister(),
              'login': (context) => MyLogin(),
              'complaint': (context) => Complaint(),
              'status': (context) => Status(),
              'upcoming': (context) => Upcoming(),
            },
          );
        });
  }
}
