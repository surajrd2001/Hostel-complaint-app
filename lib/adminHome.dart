// import 'package:flutter/material.dart';
// import 'package:hostel_app/complaint.dart';

// import 'package:hostel_app/upcoming.dart';
// import 'package:hostel_app/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:hostel_app/home.dart';
// import 'package:hostel_app/readdataAdmin.dart';
// import 'package:hostel_app/readdataAdmin.dart';
// import 'formstatus.dart';

// class adminHome extends StatefulWidget {
//   _adminHome createState() => _adminHome();
// }

// class _adminHome extends State<adminHome> {
//   final storage = new FlutterSecureStorage();
//   final user = FirebaseAuth.instance.currentUser!;
//   List<String> docIDs = [];
//   Future getDocId() async {
//     await FirebaseFirestore.instance
//         .collection('complaint')
//         .get()
//         .then((snapshot) => snapshot.docs.forEach(
//               (document) {
//                 print(document.reference);
//                 docIDs.add(document.reference.id);
//               },
//             ));
//   }

//   @override
//   Widget allComplaints() {
//     return Container(
//       child: Expanded(
//           child: FutureBuilder(
//               future: getDocId(),
//               builder: (context, snapshot) {
//                 return ListView.builder(
//                     itemCount: docIDs.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(1.0),
//                         child: ListTile(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           title: readDataAdmin(documentId: docIDs[index]),
//                         ),
//                       );
//                     });
//               })),
//       // child:
//       // ListView.builder(
//       //     itemCount: 3,
//       //     itemBuilder: (context, index) {
//       //       return ListTile(
//       //         title: Text('name'),
//       //       );
//       //     })
//     );
//   }

//   Widget build(BuildContext context) {
//     return Container(
//       child: Expanded(
//           child: FutureBuilder(
//               future: getDocId(),
//               builder: (context, snapshot) {
//                 return ListView.builder(
//                     itemCount: docIDs.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(1.0),
//                         child: ListTile(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           title: readDataAdmin(documentId: docIDs[index]),
//                         ),
//                       );
//                     });
//               })),
//       // child:
//       // ListView.builder(
//       //     itemCount: 3,
//       //     itemBuilder: (context, index) {
//       //       return ListTile(
//       //         title: Text('name'),
//       //       );
//       //     })
//     );
//   }
// }
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
