import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hostel_app/complaint.dart';
import 'package:hostel_app/home.dart';
import 'package:hostel_app/login.dart';
import 'package:hostel_app/register.dart';

import 'package:hostel_app/upcoming.dart';

import 'adminHome.dart';
import 'formstatus.dart';
import 'package:page_transition/page_transition.dart';
//import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
            home: Splashscreen(),

            routes: {
              'home': (context) => MyHome(),
              'register': (context) => MyRegister(),
              'login': (context) => MyLogin(),
              'complaint': (context) => FormScreen(),
              'status': (context) => status(),
              'upcoming': (context) => Upcoming(),
            },
          );
        });
  }
}

class Splashscreen extends StatelessWidget {
  Splashscreen({Key? key}) : super(key: key);

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
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset('assets/images/GCEK_logo.png', height: 200),
          SizedBox(height: 10),
          Text(
            'Hostel Complaint App',
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      ),
      backgroundColor: Color.fromARGB(255, 87, 212, 216),
      nextScreen: FutureBuilder(
          future: checkLoginStatus(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return MyHome();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator()));
            }
            return MyLogin();
          }),
      splashIconSize: 250,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}

// String role = "";
// final user = FirebaseAuth.instance.currentUser!;

// _checkRole() async {
//   User? user = FirebaseAuth.instance.currentUser;
//   final DocumentSnapshot snap =
//       await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();

//   if (role == 'user') {
//     return MyHome();
//   } else if (role == 'admin') {
//     return adminHome();
//   }
// }
