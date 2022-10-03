import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:hostel_app/formstatus.dart';

import 'complaintsubmit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  TextEditingController _date = new TextEditingController();
  TextEditingController _room_no = new TextEditingController();
  TextEditingController _problem_description = new TextEditingController();
  TextEditingController _phoneNo = new TextEditingController();
  TextEditingController _hostel = new TextEditingController();
  TextEditingController _complaintTyp = new TextEditingController();

  String hostel = '';
  String complaint = '';

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick an image: $e');
    }
  }

  List hostelNamelist = [
    {"title": "1. Hostel B", "value": "Hostel B"},
    {"title": "2. Hostel C", "value": "Hostel C"},
    {"title": "3. Hostel D", "value": "Hostel D"},
    {"title": "4. Jijau Hostel", "value": "Jijau Hostel"},
  ];

  List complaintTypeList = [
    {"title": "1. Electricity", "value": "Electricity"},
    {"title": "2. Plumbing", "value": "Plumbing"},
    {"title": "3. Furniture", "value": "Furniture"},
  ];

  TextEditingController nameController = TextEditingController();

  String defaultValueforComplaint = "";

  String defaultValue = "";
  // File? imageFile;
  String _name = "";

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
                    buildButton(
                        title: 'Pick Image from Gallery',
                        icon: Icons.add_photo_alternate_rounded,
                        onClicked: () => pickImage()),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(222, 11, 195, 215),
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 20),
                          textStyle: TextStyle(
                              fontSize: 33, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          FirebaseFirestore.instance
                              .collection("complaint")
                              .add({
                            "Phone No.": _phoneNo.text,
                            "room No.": _room_no.text,
                            "Discreption": _problem_description.text,
                            "hostel": hostel.toString(),
                            "complaint Type": complaint.toString(),
                            "Timestamp": new DateTime.now()
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
