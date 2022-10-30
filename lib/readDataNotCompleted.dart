import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/formstatus.dart';

class readDataNotCompleted extends StatelessWidget {
  final String documentId;
  readDataNotCompleted({required this.documentId});
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
          if (data['status'] == 'false') {
            return Card(
              elevation: 5,
              shadowColor: Colors.blueAccent,
              color: Color.fromARGB(255, 163, 231, 232),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: ListTile(
                        title: Text(
                          'Complaint Type: ${data['complaint Type']}' +
                              '\n' +
                              'Descreption: ${data['Discreption']}' +
                              '\n' +
                              'hostel: ${data['hostel']}' +
                              '      \n' +
                              'Room No: ${data['room No.']}' +
                              '\n' +
                              'Date: ${data['Date']}',
                          style: TextStyle(fontSize: 17),
                        ),
                        leading: Column(
                          children: [
                            Expanded(
                              child: SizedBox(
                                  child: Container(
                                // width: 100,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => Dialog(
                                                  child: Container(
                                                    height: 500,
                                                    width: 300,
                                                    child: Card(
                                                      semanticContainer: true,
                                                      child: InteractiveViewer(
                                                        panEnabled: false,
                                                        clipBehavior: Clip.none,
                                                        child: data.containsKey(
                                                                'image')
                                                            ? Image.network(
                                                                '${data['image']}',
                                                                fit:
                                                                    BoxFit.fill,
                                                              )
                                                            : Container(),
                                                      ),
                                                      elevation: 4,
                                                    ),
                                                  ),
                                                )));
                                  },
                                  child: Container(
                                    child: data.containsKey('image')
                                        ? Image.network(
                                            '${data['image']}',
                                            fit: BoxFit.fill,
                                          )
                                        : Container(),
                                  ),
                                ),
                              )),
                            )
                          ],
                        )),
                  )
                ],
              ),
            );
          }
        }
        return Text('.');
      }),
    );
  }
}
