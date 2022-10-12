//import 'dart:html';

// import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hostel_app/adminHome.dart';
import 'package:hostel_app/register.dart';
import 'package:hostel_app/running.dart';
import 'hexcolour.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_app/home.dart';
import 'package:hostel_app/adminHome.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //used for storing user credentials for continue login
  final storage = new FlutterSecureStorage();

  void userLogin() async {
    try {
      FirebaseDatabase database = FirebaseDatabase.instance;
      //login can be done , here we use code for continue login by condition
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(userCredential.user?.uid);
      // var user = FirebaseAuth.instance.currentUser;
      // final userId = user!.uid;

      final storage = new FlutterSecureStorage();
      final user = FirebaseAuth.instance.currentUser!;
      final userId = user.uid;
      await storage.write(key: "uid", value: userCredential.user?.uid);
      // ignore: deprecated_member_use
      String? value = await storage.read(key: "uid");
      // await FirebaseDatabase.instance
      //     .reference()
      //     .child("complaint")
      //     .child(userId)
      //     .once()
      //     .then((DatabaseEvent event) {
      //   setState(() {
      //     if (event == 'SJuaMnzQabdHglxPkjgpuGccNw52') {
      //       Navigator.push(
      //           context, MaterialPageRoute(builder: (context) => adminHome()));
      //     } else {
      //       Navigator.push(
      //           context, MaterialPageRoute(builder: (context) => MyHome()));
      //     }
      //   });
      // });
      //     .then((DataSnapshot snapshot) {
      //   if (userId == "SJuaMnzQabdHglxPkjgpuGccNw52") {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => adminHome()));
      //   } else {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => MyHome()));
      //   }
      // });
      //     .then((DataSnapshot snapshot) {
      //   setState(() {
      //     if (snapshot.value['uid'] == 'Wd7WeEdhwPY7UTRADEUfPD0Oq5o1') {
      //       Navigator.push(
      //           context, MaterialPageRoute(builder: (context) => adminHome()));
      //     } else {
      //       Navigator.push(
      //           context, MaterialPageRoute(builder: (context) => MyHome()));
      //     }
      //   });
      // });
      if (userId == 'SJuaMnzQabdHglxPkjgpuGccNw52') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => adminHome(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHome(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No User Found for that Email");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print("Wrong Password Provided by User");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4")
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, top: 55, bottom: 68),
                  child: Text(
                    'Welcome\nBack...!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      shadows: <Shadow>[
                        Shadow(
                          blurRadius: 10.0,
                          color: Color.fromARGB(255, 3, 82, 147),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 20, top: 88, bottom: 68),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/complaintlogo.png'),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email';
                      } else if (!value.contains('@')) {
                        return 'Please Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: true,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(255, 255, 254, 254),
                      filled: true,
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Password';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              email = emailController.text;
                              password = passwordController.text;
                            });
                            userLogin();
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an Account? ",
                        style: TextStyle(
                            color: Color.fromARGB(150, 213, 203, 203)),
                      ),

                      TextButton(
                        onPressed: () => {
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, a, b) => MyRegister(),
                                transitionDuration: Duration(seconds: 0),
                              ),
                              (route) => false)
                        },
                        child: Text(
                          'Signup',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () => {
                      //     Navigator.pushAndRemoveUntil(
                      //         context,
                      //         PageRouteBuilder(
                      //           pageBuilder: (context, a, b) => UserMain(),
                      //           transitionDuration: Duration(seconds: 0),
                      //         ),
                      //         (route) => false)
                      //   },
                      //   child: Text('Dashboard'),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
