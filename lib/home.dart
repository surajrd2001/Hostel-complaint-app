//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hostel_app/complaint.dart';

import 'package:hostel_app/upcoming.dart';
import 'package:hostel_app/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'formstatus.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  // create object storage of FlutterSecureStorage class
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; //height and width of our device
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 243, 246),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 1, 205, 215),
        elevation: 10,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "DashBoard",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            ElevatedButton(
              onPressed: () async => {
                //this is used to signout after authentication
                await FirebaseAuth.instance.signOut(),
                //here we delete the object in which uid is stored which delete the uid and new user can able to login
                await storage.delete(key: "uid"),
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyLogin(),
                    ),
                    (route) => false)
              },
              child: Text('SignOut'),
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
            )
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .30,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/college.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    width: double.infinity,
                    height: 60,
                  ),
                  Container(
                    // margin: const EdgeInsets.only(left: 20.0),
                    child: SafeArea(
                      child: Row(),
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 120,
                  ),
                  Expanded(
                      child: GridView.count(
                    crossAxisCount: 2,
                    //childAspectRatio: .85,
                    crossAxisSpacing: 22,
                    mainAxisSpacing: 30,

                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => FormScreen())));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(111, 10, 217, 232),
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 2.0,
                                  ),
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.assignment_rounded,
                                  size: 50,
                                  color: Color.fromARGB(255, 3, 158, 235),
                                ),
                                // Spacer(),
                                Text(
                                  'COMPLAINT',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                )
                              ],
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => status())));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(111, 10, 217, 232),
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 2.0,
                                  ),
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.pending_actions,
                                  size: 50,
                                  color: Color.fromARGB(255, 3, 158, 235),
                                ),
                                // Spacer(),
                                Text(
                                  'COMPLAINT STATUS',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                )
                              ],
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Upcoming())));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(111, 10, 217, 232),
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 2.0,
                                  ),
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.moving,
                                  size: 50,
                                  color: Color.fromARGB(255, 3, 158, 235),
                                ),
                                //Spacer(),
                                Text(
                                  'UPCOMING',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                )
                              ],
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Upcoming())));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(111, 10, 217, 232),
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 2.0,
                                  ),
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.moving,
                                  size: 50,
                                  color: Color.fromARGB(255, 3, 158, 235),
                                ),
                                //Spacer(),
                                Text(
                                  'UPCOMING',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                )
                              ],
                            )),
                      ),

                      /*   CategoryCard(
                        svgSrc:
                            'https://media.istockphoto.com/photos/city-map-3d-illustration-picture-id477560990?s=612x612',
                        title: "Campus",
                        press: () {},
                      ),
                      CategoryCard(
                        svgSrc: 'assets/icons/icons8-home.svg',
                        title: "Attendance History",
                        press: () {},
                      ),
                      CategoryCard(
                        svgSrc: 'assets/icons/icons8-home.svg',
                        title: "Leave Application",
                        press: () {},
                      ),
                      CategoryCard(
                        svgSrc: 'assets/icons/icons8-home.svg',
                        title: "Leave Summary",
                        press: () {},
                      ),*/
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
