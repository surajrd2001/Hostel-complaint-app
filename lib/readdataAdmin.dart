import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class readDataAdmin extends StatelessWidget {
  final String documentId;
  readDataAdmin({required this.documentId});
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
          return Card(
            elevation: 5,
            shadowColor: Colors.blueAccent,
            color: Color.fromARGB(255, 163, 231, 232),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            borderOnForeground: false,
            child: Container(
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.black87,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: Container(
                                  height: 200,
                                  width: 300,

                                  child: Card(
                                    child: new Column(
                                      children: <Widget>[
                                        new ElevatedButton(
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection('complaint')
                                                .doc(documentId)
                                                .update({'status': 'true'})
                                                .then(
                                                    (value) => print('success'))
                                                .catchError((error) =>
                                                    print('failed: $error'));
                                          },
                                          child: new Text('Completed'),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.green,
                                            onPrimary: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ),

                                  // semanticContainer: true,
                                ),
                              ));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Complaint Type: ${data['complaint Type']}' +
                          '\n' +
                          'Discreption: ${data['Discreption']}' +
                          '\n' +
                          'hostel: ${data['hostel']}' +
                          '      \t' +
                          'Room No: ${data['room No.']}' +
                          '\n' +
                          'Date: ${data['Date']}',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
          );
          // return Text('Complaint Type: ${data['complaint Type']}');
        }
        return Text('Loading..');
      }),
    );
  }
}
