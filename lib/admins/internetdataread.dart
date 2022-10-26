import 'dart:ffi';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:hostel_app/readdataAdmin.dart';

class Internetmainpage extends StatefulWidget {
  const Internetmainpage({Key? key}) : super(key: key);
  @override
  State<Internetmainpage> createState() => _Internetmainpage();
}

class _Internetmainpage extends State<Internetmainpage> {
  final storage = new FlutterSecureStorage();
  final user = FirebaseAuth.instance.currentUser!;
  List<String> docIDs = [];
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('complaint')
        .where('complaint Type', isEqualTo: 'Internet')
        .get()
        .then((snapshot) => snapshot.docs.forEach(
              (documnet) {
                print(documnet.reference);
                docIDs.add(documnet.reference.id);
              },
            ));
  }

//To retrieve the string
// String documentID = await get_data();

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
                          title: readDataAdmin(documentId: docIDs[index]),
                          // leading: IconButton(
                          //   icon: Icon(Icons.edit),
                          //   color: Colors.black87,
                          //   onPressed: () {
                          //     showDialog(
                          //         context: context,
                          //         builder: (context) => Dialog(
                          //               child: Container(
                          //                 height: 200,
                          //                 width: 300,

                          //                 child: Card(
                          //                   child: new Column(
                          //                     children: <Widget>[
                          //                       new ElevatedButton(
                          //                         onPressed: () {
                          //                           FirebaseFirestore.instance
                          //                               .collection('complaint')
                          //                               .doc(
                          //                                   'Tv2FndT2tx7PStSpP3E1')
                          //                               .update(
                          //                                   {'status': 'true'})
                          //                               .then((value) =>
                          //                                   print('success'))
                          //                               .catchError((error) =>
                          //                                   print(
                          //                                       'failed: $error'));
                          //                         },
                          //                         child: new Text('Completed'),
                          //                         style:
                          //                             ElevatedButton.styleFrom(
                          //                           primary: Colors.green,
                          //                           onPrimary: Colors.white,
                          //                         ),
                          //                       ),
                          //                       new ElevatedButton(
                          //                         onPressed: () {
                          //                           FirebaseFirestore.instance
                          //                               .collection('complaint')
                          //                               .doc(
                          //                                   'Tv2FndT2tx7PStSpP3E1')
                          //                               .update(
                          //                                   {'status': 'false'})
                          //                               .then((value) =>
                          //                                   print('success'))
                          //                               .catchError((error) =>
                          //                                   print(
                          //                                       'failed: $error'));
                          //                         },
                          //                         child:
                          //                             new Text('Not Completed'),
                          //                         style:
                          //                             ElevatedButton.styleFrom(
                          //                           primary: Colors.red,
                          //                           onPrimary: Colors.white,
                          //                         ),
                          //                       )
                          //                     ],
                          //                   ),
                          //                   shape: RoundedRectangleBorder(
                          //                       borderRadius:
                          //                           BorderRadius.circular(
                          //                               20.0)),
                          //                 ),

                          //                 // semanticContainer: true,
                          //               ),
                          //             ));
                          //   },
                          // ),
                          subtitle: Column(
                            children: <Widget>[
                              // ElevatedButton(
                              //     onPressed: () {},
                              //     child: Text('Not Completed'))
                            ],
                          ),
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
