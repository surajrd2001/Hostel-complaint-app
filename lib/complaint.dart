import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:hostel_app/formstatus.dart';
import 'package:hostel_app/user_image_picker.dart';
import 'complaintsubmit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late File image1;
  TextEditingController _date = new TextEditingController();
  TextEditingController _room_no = new TextEditingController();
  TextEditingController _problem_description = new TextEditingController();
  TextEditingController _phoneNo = new TextEditingController();
  TextEditingController _hostel = new TextEditingController();
  TextEditingController _complaintTyp = new TextEditingController();

  String hostel = '';
  String complaint = '';

  File? image;
  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;
  //     final imageTemporary = File(image.path);
  //     setState(() => this.image = imageTemporary);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick an image: $e');
  //   }
  // }
  final user = FirebaseAuth.instance.currentUser!;
  PlatformFile? pickedFile;
  Future _pickImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
    final path = 'user_images/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
  }

  List hostelNamelist = [
    {"title": "1. Hostel B", "value": "Hostel B"},
    {"title": "2. Hostel C", "value": "Hostel C"},
    {"title": "3. Hostel D", "value": "Hostel D"},
    {"title": "4. Jijau Hostel", "value": "Jijau Hostel"},
  ];
  File? _userImageFile;
  void _pickedImage(File image1) {
    _userImageFile = image1;
  }

  List complaintTypeList = [
    {"title": "1. Electricity", "value": "Electricity"},
    {"title": "2. Plumbing", "value": "Plumbing"},
    {"title": "3. Furniture", "value": "Furniture"},
    {"title": "3. Cleaning", "value": "cleaning"},
    {"title": "3. Internet", "value": "Internet"},
  ];

  TextEditingController nameController = TextEditingController();

  String defaultValueforComplaint = "";
  final storage = new FlutterSecureStorage();

  String defaultValue = "";
  // File? imageFile;
  String _name = "";

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('complaint-list');
  Widget _hostelname() {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(25),
      shadowColor: Colors.blueAccent,
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            labelText: 'Select Hostel: ',
            labelStyle: TextStyle(color: Colors.black, fontSize: 17.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white24, width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
            fillColor: Colors.white70,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white24, width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          value: defaultValue,
          //isExpanded: true,
          items: [
            const DropdownMenuItem(child: Text("Select Hostel"), value: ""),
            ...hostelNamelist.map<DropdownMenuItem<String>>((e) {
              return DropdownMenuItem(
                  child: Text(e['title']), value: e['value']);
            }).toList(),
          ],
          onChanged: (value) {
            setState(() => hostel = value.toString());
          }),
    );
  }

  Widget _complaintType() {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(25),
      shadowColor: Colors.blueAccent,
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black),
            labelText: 'Select Complaint Type: ',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white24, width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
            fillColor: Colors.white70,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white24, width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          value: defaultValue,
          //isExpanded: true,
          items: [
            const DropdownMenuItem(child: Text("Complaint Type"), value: ""),
            ...complaintTypeList.map<DropdownMenuItem<String>>((e) {
              return DropdownMenuItem(
                  child: Text(e['title']), value: e['value']);
            }).toList(),
          ],
          onChanged: (val) {
            setState(() => complaint = val.toString());
          }),
    );
  }

  Widget _buildName() {
    return Material(
      elevation: 18,
      shadowColor: Colors.purpleAccent,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Name:',
          border: OutlineInputBorder(),
          labelStyle: TextStyle(fontSize: 16.0),
          fillColor: Colors.white70,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        controller: nameController,
      ),
    );
  }

  Widget _problemDescription() {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(25),
      shadowColor: Colors.blueAccent,
      child: TextFormField(
        controller: _problem_description,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: 'Problem Description:',
          hintText: 'Detailed Description',
          labelStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          fillColor: Colors.white70,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        maxLines: 5,
        validator: MultiValidator(
            [RequiredValidator(errorText: 'Required complaint Discription')]),
      ),
    );
  }

  Widget _complaintDate() {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(25),
      shadowColor: Colors.blueAccent,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: _date,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          labelStyle: TextStyle(color: Colors.black),
          labelText: "Select Date:",
          suffixIcon: Icon(
            Icons.calendar_today_rounded,
            color: Color.fromARGB(255, 134, 123, 123),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          fillColor: Colors.white70,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onTap: () async {
          DateTime? pickeddate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2022),
              lastDate: DateTime.now());

          if (pickeddate != null) {
            setState(() {
              _date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
            });
          }
        },
        validator: MultiValidator(
            [RequiredValidator(errorText: 'Required complaint date')]),
      ),
    );
  }

  Widget _roomNo() {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(25),
      shadowColor: Colors.blueAccent,
      child: TextFormField(
        controller: _room_no,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black, fontSize: 16.0),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          labelText: 'Room No:',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        validator:
            MultiValidator([RequiredValidator(errorText: 'Required room no')]),
        onSaved: (value) {
          print(value);
        },
      ),
    );
  }

  Widget _phoneNumber() {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(25),
      shadowColor: Colors.blueAccent,
      child: TextFormField(
        controller: _phoneNo,
        decoration: InputDecoration(
          labelText: 'Phone Number: ',
          labelStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          fillColor: Colors.white70,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        keyboardType: TextInputType.phone,
      ),
    );
  }

  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          elevation: 10,
          shadowColor: Colors.blueAccent,
          textStyle: TextStyle(fontSize: 14),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          side: BorderSide(color: Colors.white12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 36),
            Text(title),
          ],
        ),
        onPressed: onClicked,
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Color.fromARGB(255, 246, 243, 243)),
              onPressed: () => Navigator.of(context).pop()),
          title: Text("Student Complaint Page"),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 1, 205, 215),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background image.png'),
                    fit: BoxFit.fill)),
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(33.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _complaintDate(),
                    SizedBox(height: 20),
                    _phoneNumber(),
                    SizedBox(height: 23),
                    _hostelname(),
                    SizedBox(height: 23),
                    _roomNo(),
                    SizedBox(height: 23),
                    _complaintType(),
                    SizedBox(height: 23),
                    _problemDescription(),
                    SizedBox(height: 23),
                    ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: Icon(Icons.image),
                      label: Text('pick image from gallery'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black87,
                        minimumSize: const Size(390, 50),
                        // maximumSize: const Size(200, 200),
                      ),
                    ),
                    // buildButton(
                    //     title: 'Pick Image from Gallery',
                    //     icon: Icons.add_photo_alternate_rounded,
                    //     onClicked: () => pickImage()),
                    //
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(222, 11, 195, 215),
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 20),
                          textStyle: TextStyle(
                              fontSize: 33, fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          String? value = await storage.read(key: "uid");
                          FirebaseFirestore.instance
                              .collection("complaint")
                              .add({
                            "Date": _date.text,
                            "Phone No.": _phoneNo.text,
                            "room No.": _room_no.text,
                            "Discreption": _problem_description.text,
                            "hostel": hostel.toString(),
                            "complaint Type": complaint.toString(),
                            "uid": value.toString(),
                            "status": false,
                            //"Timestamp": new DateTime.now()
                          }).then((value) {
                            print('the complaint id is ' + value.id);

                            _date.clear();
                            _room_no.clear();
                            _problem_description.clear();
                            _hostel.clear();
                            _phoneNo.clear();
                            _complaintTyp.clear();
                            DateTime.now();
                          }).catchError((error) => print(error));

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => complaintSubmit()),
                          );
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
