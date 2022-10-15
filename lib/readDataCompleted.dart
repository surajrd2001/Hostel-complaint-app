import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/formstatus.dart';

class readDataCompleted extends StatelessWidget {
  final String documentId;
  readDataCompleted({required this.documentId});
  @override
  Widget build(BuildContext context) {
    CollectionReference complaint =
        FirebaseFirestore.instance.collection('complaint');

    return FutureBuilder<DocumentSnapshot>(
      future: complaint.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          if (data['status'] == 'true') {
            return Card(
              elevation: 5,
              shadowColor: Colors.blueAccent,
              color: Color.fromARGB(255, 163, 231, 232),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              borderOnForeground: false,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Complaint Id: $documentId' +
                        '\n'
                            'Complaint Type: ${data['complaint Type']}' +
                        '\n' +
                        'Discreption: ${data['Discreption']}' +
                        '\n' +
                        'Date: ${data['Date']}',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            );
          }
          // return Text('Complaint Type: ${data['complaint Type']}');
        }
        return Text('');
      }),
    );
  }
}
