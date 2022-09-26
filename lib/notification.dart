import 'package:flutter/material.dart';

class Notification extends StatefulWidget {
  @override
  _NotificationState createState() => new _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    return _buildPostList();
  }

  Widget _buildPostList() {
    return new Scaffold(
        backgroundColor: Colors.blue,
        body: new Scrollbar(
            child: new ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return new Container(
                child: new Stack(children: <Widget>[
              new Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0.0, left: 12.0),
                    //DummyPost())
                  ),
                ],
              ),
              //replyNotification(),
            ]));
          },
          itemCount: 2,
        )));
  }
}
