// import 'dart:html';
// import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/complaint.dart';

// class status extends StatefulWidget {
//   const status({Key? key}) : super(key: key);

//   @override
//   State<status> createState() => _statusState();
// }

// class _statusState extends State<status> with TickerProviderStateMixin {
// late TabController _tabController;

// late bool _isLoggedIn;
// @override
// void initState() {
//   super.initState();
//   _tabController = TabController(length: 2, vsync: this);
// }
class status extends StatelessWidget {
  Widget _status() {
    return Material();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 1, 205, 215),
          title: Text('Complaint Status'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Running',
                icon: Icon(Icons.loop_rounded),
              ),
              Tab(
                text: 'Completed',
                icon: Icon(Icons.assignment_turned_in),
              )
            ],
          ),
        ),
      ),
      length: 2,
    );
  }
}

// class status extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         child: (DefaultTabController(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Complaint Status'),
//           centerTitle: true,
//           bottom: TabBar(
//             tabs: [
//               Tab(
//                 text: 'Running',
//                 icon: Icon(Icons.error),
//               ),
//               Tab(
//                 text: 'Completed',
//                 icon: Icon(Icons.error),
//               )
//             ],
//           ),
//         ),
//       ),
//       length: 2,
//     )));
//     // return Scaffold(
//     //   appBar: AppBar(
//     //     title: Text('My Orders'),
//     //     centerTitle: true,
//     //     backgroundColor: Color.fromARGB(255, 146, 234, 240),
//     //   ),
//     //   body: Column(
//     //     children: [
//     //       Container(
//     //         child: TabBar(
//     //           indicatorColor: Colors.white70,
//     //           indicatorWeight: 3,
//     //           labelColor: Colors.black87,
//     //           unselectedLabelColor: Theme.of(context).disabledColor,
//     //           controller: _tabController,
//     //           tabs: [
//     //             Tab(
//     //               text: 'Running',
//     //             ),
//     //             Tab(
//     //               text: 'History',
//     //             )
//     //           ],
//     //         ),
//     //       ),
//     //       Expanded(
//     //         child: TabBarView(controller: _tabController, children: [

//     //           complaints(),

//     //           // Text('order 1'),
//     //           Text('order 2'),
//     //         ]),
//     //       )
//     //     ],
//     //   ),
//     // );
//   }
// }
