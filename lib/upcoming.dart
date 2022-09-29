import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Upcoming extends StatelessWidget {
  const Upcoming({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Welcome',
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Welcome',
              style: TextStyle(fontSize: 25),
            ),
          ),
          body: const Center(
            child: Text(
              'We are working on Upcoming Features',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ));
  }
}
