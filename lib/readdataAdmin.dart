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

                                child: Center(
                                  child: Card(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('complaint')
                                            .doc(documentId)
                                            .update({'status': 'true'})
                                            .then((value) => print('success'))
                                            .catchError((error) =>
                                                print('failed: $error'));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: new Text('Completed'),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        onPrimary: Colors.white,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ),
                                ),

                                // semanticContainer: true,
                              ),
                            ));
                  },
                ),
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
                                                              fit: BoxFit.fill,
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
        return Text('Loading..');
      }),
    );
  }
}
