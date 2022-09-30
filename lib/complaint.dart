import 'dart:io';

import 'package:flutter/services.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:hostel_app/formstatus.dart';

import 'complaintsubmit.dart';

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
  // TextEditingController _date = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  // Widget _pickImage() {
  //   return Scaffold(
  //     body: Padding(
  //       padding: const EdgeInsets.all(12.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           if(imageFile !=null)
  //             Container(
  //             width: 34,
  //             height: 50,
  //             alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //               color: Colors.grey,
  //               image: DecorationImage(image:FileImage(imageFile) ),

  //               border: Border.all(width: 8, color: Colors.black12),
  //               borderRadius: BorderRadius.circular(12.0),
  //             ),

  //              ),
  //           else
  //             Container(
  //               width: 34,
  //               height: 50,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                 color: Colors.grey,
  //                 border: Border.all(width: 8, color: Colors.black12),
  //                 borderRadius: BorderRadius.circular(12.0),
  //               ),
  //               child: const Text('img'),
  //             ),

  //           Row(
  //             children: [
  //               Expanded(
  //                 child: ElevatedButton(
  //                   onPressed: () => getImage(source: ImageSource.camera),
  //                   child: const Text(
  //                     'pick img',
  //                     style: TextStyle(fontSize: 18),
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(
  //                 width: 20,
  //               ),
  //               Expanded(
  //                   child: ElevatedButton(
  //                 onPressed: () => getImage(source: ImageSource.gallery),
  //                 child: const Text(
  //                   'pick img',
  //                   style: TextStyle(fontSize: 18),
  //                 ),
  //               ))
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  // Widget pickImage() {
  //   return Scaffold(
  //     body: Column(children: [
  //       Align(
  //         alignment: Alignment.center,
  //         child: Stack(
  //           children: [
  //             Container(
  //               decoration: BoxDecoration(
  //                 border: Border.all(color: Colors.indigo, width: 5),
  //                 borderRadius: const BorderRadius.all(
  //                   Radius.circular(100),
  //                 ),
  //               ),
  //               child: ClipOval(
  //                 child: Image.network(
  //                   'https://upload.wikimedia.org/wikipedia/commons/5/5f/Alberto_conversi_profile_pic.jpg',
  //                   width: 170,
  //                   height: 170,
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //               bottom: 0,
  //               right: 5,
  //               child: IconButton(
  //                 onPressed: () {},
  //                 icon: const Icon(
  //                   Icons.add_a_photo_outlined,
  //                   color: Colors.blue,
  //                   size: 30,
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 20,
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: ElevatedButton.icon(
  //             onPressed: () {},
  //             icon: const Icon(Icons.add_a_photo_sharp),
  //             label: const Text('UPLOAD IMAGE')),
  //       )
  //     ]),
  //   );
  // }

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

  // Widget _hostelnamelist()
  // {
  //   return DropdownButtonFormField(items: items, onChanged: onChanged)
  // }

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
    // return TextFormField(

    //   decoration: InputDecoration(

    //     labelText: 'Name:',
    //     border: OutlineInputBorder(),
    //     labelStyle: TextStyle(fontSize: 16.0),
    //     fillColor: Colors.white70,
    //     filled: true,
    //     focusedBorder: OutlineInputBorder(
    //       borderSide: BorderSide(color: Colors.blueGrey, width: 2),
    //       borderRadius: BorderRadius.circular(25),
    //     ),
    //   ),
    //   validator: (value) {
    //     if (value == null || value.isEmpty) {
    //       return 'Name is required';
    //     }
    //     return null;
    //   },
    //   onSaved: (value) {
    //     print(value);
    //   },
    // );
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

  // Widget _problemDescription() {
  //   return TextField(
  //     textInputAction: TextInputAction.newline,
  //     decoration: InputDecoration(
  //       hintText: "Detailed Description",
  //       labelText: 'Problem Description:',
  //       labelStyle: TextStyle(fontSize: 16.0),
  //       enabledBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.blueGrey, width: 2),
  //         borderRadius: BorderRadius.circular(25),
  //       ),
  //       fillColor: Colors.white70,
  //       filled: true,
  //       focusedBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.blueGrey, width: 2),
  //         borderRadius: BorderRadius.circular(25),
  //       ),
  //     ),
  //     obscureText: false,
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Name is required';
  //       }
  //       return null;
  //     },
  //     onSaved: (value) {
  //       print(value);
  //     },
  //     maxLines: 3,
  //   );
  // }

  Widget _roomNo() {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(25),
      shadowColor: Colors.blueAccent,
      child: TextFormField(
        controller: _room_no,
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
        validator:
            MultiValidator([RequiredValidator(errorText: 'Required room no')]),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Name is required';
        //   } else
        //     null;
        // },
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
              _date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
            });
          }
        },
        validator: MultiValidator(
            [RequiredValidator(errorText: 'Required complaint date')]),
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

                    SizedBox(height: 23),
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
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text('processing data')),
                          // );
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => status(
                          //         date: _date.text,
                          //         room_no: _room_no.text,
                          //         problem_description:
                          //             _problem_description.text)));

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

                    // RaisedButton(
                    //   onPressed: () {
                    //     // isButonActive
                    //     //     ? () {
                    //     //         setState(() => isButonActive = false);
                    //     //       }
                    //     //     : null,
                    //     // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>complaintSubmit(),));
                    //     // Navigator.push(
                    //     //     context,
                    //     //     MaterialPageRoute(
                    //     //         builder: (context) => complaintSubmit())),
                    //     // if (_formkey.currentState!.validate()) {},
                    //     // _formkey.currentState!.save(),
                    //     _formkey.currentState?.validate();

                    //     // Navigator.of(context).push(MaterialPageRoute(
                    //     //   builder: (context) => complaintSubmit(),
                    //     // ));
                    //   },
                    //   // child: Text(
                    //   //   'Submit',
                    //   //   style: TextStyle(
                    //   //     color: Colors.black,
                    //   //     fontSize: 16,
                    //   //   ),
                    //   // ),
                    //   padding: EdgeInsets.zero,
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.all(Radius.circular(30))),
                    //   child: Container(
                    //     height: 45,
                    //     padding:
                    //         EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                    //     decoration: BoxDecoration(
                    //         gradient: LinearGradient(
                    //           colors: [
                    //             Color.fromARGB(255, 181, 220, 201),
                    //             Color.fromARGB(255, 199, 208, 224)
                    //           ],
                    //           begin: Alignment.centerLeft,
                    //           end: Alignment.centerRight,
                    //         ),
                    //         borderRadius:
                    //             const BorderRadius.all(Radius.circular(25))),
                    //     child: Center(
                    //       child: GestureDetector(
                    //         onTap: () {},
                    //         child: Text(
                    //           'Submit',
                    //           textAlign: TextAlign.left,
                    //           style: TextStyle(
                    //               fontFamily: "Netflix",
                    //               fontWeight: FontWeight.w600,
                    //               fontSize: 18,
                    //               letterSpacing: 0.0,
                    //               color: Colors.black87),
                    //         ),
                    //       ),
                    //     ),
                    //   ),

                    //   //   Navigator.push(context,
                    //   //    MaterialPageRoute(builder:(context)=> complaintSubmit()),);},
                    //   //   if (_formkey.currentState!.validate()) {},
                    //   //   _formkey.currentState!.save(),

                    //   // },
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void getImage({required ImageSource source}) async {
  //   final file = await ImagePicker().pickImage(source: source);
  //   if (file?.path != null) {
  //     setState(() {
  //       //imageFile = File(file!.path);
  //     });
  //   }
  // }
}
