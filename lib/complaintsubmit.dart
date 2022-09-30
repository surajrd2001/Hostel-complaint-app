import 'package:flutter/material.dart';

// import 'package:uuid/uuid.dart';

// class complaintSubmit extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return complaintSubmitState();
//   }
// }

// class complaintSubmitState extends State<complaintSubmit> {
//   var uuid = Uuid();
//   Widget uniqueId() {
//     return Scaffold(
//       body: Column(
//         children: [
//           Card(
//             child: ListTile(
//               title: Text('Unique Id for complaint: '),
//               subtitle: Text(uuid.v1()),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.all(24),
//           child: Form(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   uniqueId(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class complaintSubmit extends StatelessWidget {
  Widget _complaintSubmitted() {
    return Material();
  }

// class complaintSubmit extends StatelessWidget{
//   Widget _complaintSubmitted(){
//     return Material();
//   }
// }
  // var uuid = Uuid();
  // Widget uniqueId() {
  //   return Scaffold(
  //     body: Column(
  //       children: [
  //         Card(
  //           child: ListTile(
  //             title: Text('Unique Id for complaint: '),
  //             subtitle: Text(uuid.v1()),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 205, 215),
      ),
      body: //SingleChildScrollView(
          //     child: Container(
          //   margin: EdgeInsets.all(24),
          //   child: Form(
          //       child: Padding(
          //     padding: const EdgeInsets.all(8),
          //     child: Column(

          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: <Widget>[uniqueId(), ],
          //     ),
          //   )),
          // )),
          Center(
        child: Container(
          margin: const EdgeInsets.all(15.0),
          width: 350,
          height: 400,
          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          color: Colors.white70,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 70.0),
              child: Text(
                "Complaint\nSubmitted✅",
                style: TextStyle(color: Color(0xff023047), fontSize: 35),
              ),
            ),
          ),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(10),
          //   color: Colors.white,
          // ),
        ),
      ),
    );
    // body: Center(
    //   child: ClipRRect(
    //     child: Image.network(
    //       'https://cdn-icons-png.flaticon.com/512/2519/2519057.png',
    //       height: 200,
    //     ),
    //   ),

    // )
  }
}
