import 'package:flutter/material.dart';

class notificationscreen extends StatelessWidget {
  const notificationscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text('Notification Screens'),
        ),
        body: Text("You don't have recieved any notification yet"));
  }
}
