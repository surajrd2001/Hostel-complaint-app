//import 'package:uuid/uuid.dart';
//import 'package:flutter/foundation.dart';
// import 'dart:html';

// import 'dart:html';

//import 'package:flutter_hostel_complaint/complaintStatus.dart';
//import 'package:form_field_validator/form_field_validator.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_hostel_complaint/constants.dart';

class Complaint extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ComplaintState();
  }
}

class ComplaintState extends State<Complaint> {
  // bool isButonActive = true;
  // late TextEditingController controller;
  // @override
  // void initState() {
  //   super.initState();
  //   controller = TextEditingController();
  //   controller.addListener(() {
  //     final isButtonActive = controller.text.isNotEmpty;
  //     setState(() => this.isButonActive = isButonActive);
  //   });
  // }

  List hostelNamelist = [
    {"title": "Hostel B", "value": "1"},
    {"title": "Hostel C", "value": "2"},
    {"title": "Hostel D", "value": "3"},
    {"title": "Jijau Hostel", "value": "4"},
  ];

  List complaintTypeList = [
    {"title": "Electricity", "value": "1"},
    {"title": "Plumbing", "value": "2"},
    {"title": "Furniture", "value": "3"},
  ];

  TextEditingController nameController = TextEditingController();

  String defaultValueforComplaint = "";

  String defaultValue = "";
  // File? imageFile;
  String _name = "";
  TextEditingController _date = TextEditingController();

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
          onChanged: (value) {}),
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
            //labelStyle: TextStyle(fontSize: 16.0),
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
          onChanged: (value) {}),
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
      ),
    );
  }

  Widget _problemDescription() {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(25),
      shadowColor: Colors.blueAccent,
      child: TextFormField(
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
        //validator: MultiValidator(
        //[RequiredValidator(errorText: 'Required complaint date')]),
      ),
    );
  }

  Widget _roomNo() {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(25),
      shadowColor: Colors.blueAccent,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,

        // controller: controller,
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
          // fillColor: Colors.white70,
          // filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        //validator:
        //MultiValidator([RequiredValidator(errorText: 'Required room no')])

        onSaved: (value) {
          print(value);
        },
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
              //   _date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
            });
          }
        },
        //validator: MultiValidator(
        // [RequiredValidator(errorText: 'Required complaint date')]),
      ),
    );
  }

  Widget _phoneNumber() {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(25),
      shadowColor: Colors.blueAccent,
      child: TextFormField(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Student Complaint Page"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(197, 0, 190, 224),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _complaintDate(),
                  // SizedBox(height: 10),
                  // _buildName(),
                  SizedBox(height: 20),
                  _phoneNumber(),
                  SizedBox(height: 20),
                  _hostelname(),
                  SizedBox(height: 20),
                  _roomNo(),
                  SizedBox(height: 20),
                  _complaintType(),
                  SizedBox(height: 20),
                  _problemDescription(),

                  SizedBox(height: 180),

                  ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text('processing data')),
                        // );
                        // Navigator.push(
                        // context,
                        // MaterialPageRoute(
                        //   builder: (context) => complaintSubmit()),
                        //);
                      }
                    },
                    child: const Text('Submit'),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 193, 242, 229),
                        onPrimary: Color.fromARGB(255, 121, 179, 204),
                        textStyle: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        side: BorderSide(color: Colors.black87),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
