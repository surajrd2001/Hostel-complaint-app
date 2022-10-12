import 'package:flutter/material.dart';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hostel_app/formstatus.dart';
import 'package:hostel_app/home.dart';
import 'package:hostel_app/readData.dart';
import 'package:hostel_app/readDataCompleted.dart';

class completed extends StatelessWidget {
  final storage = new FlutterSecureStorage();
  final user = FirebaseAuth.instance.currentUser!;

  List<String> docIDs = [];
  Future getDocId() async {
    String? value = await storage.read(key: "uid");
    await FirebaseFirestore.instance
        .collection('complaint')
        .where("uid", isEqualTo: value)
        .get()
        .then((snapshot) => snapshot.docs.forEach(
              (documnet) {
                print(documnet.reference);
                docIDs.add(documnet.reference.id);
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          child: FutureBuilder(
              future: getDocId(),
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: docIDs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          title: readDataCompleted(documentId: docIDs[index]),
                        ),
                      );
                    });
              })),
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
