import 'package:flutter/material.dart';
import 'package:hostel_app/complaint.dart';
import 'package:hostel_app/home.dart';
import 'package:hostel_app/login.dart';
import 'package:hostel_app/register.dart';
import 'package:hostel_app/status.dart';
import 'package:hostel_app/upcoming.dart';
import 'package:hostel_app/notification.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyLogin(),
    routes: {
      'home': (context) => Home(),
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'complaint': (context) => Complaint(),
      'status': (context) => Status(),
      'upcoming': (context) => Upcoming(),
    },
  ));
}
