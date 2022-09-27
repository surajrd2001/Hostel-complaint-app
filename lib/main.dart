import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/complaint.dart';
import 'package:hostel_app/home.dart';
import 'package:hostel_app/login.dart';
import 'package:hostel_app/register.dart';
import 'package:hostel_app/status.dart';
import 'package:hostel_app/upcoming.dart';
import 'package:hostel_app/notification.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyLogin(),
    routes: {
      'home': (context) => MyHome(),
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'complaint': (context) => Complaint(),
      'status': (context) => Status(),
      'upcoming': (context) => Upcoming(),
    },
  ));
}
