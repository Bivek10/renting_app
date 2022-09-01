import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class bookdetail extends StatefulWidget {
  String userId;
  String name;
  String description;
  String createdDate;
  String createdTime;
  bookdetail({
    Key? key,
    required this.userId,
    required this.name,
    required this.description,
    required this.createdDate,
    required this.createdTime,
  }) : super(key: key);

  @override
  State<bookdetail> createState() => _bookdetailState();
}

class _bookdetailState extends State<bookdetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        elevation: 0.0,
        title: Text(widget.name,
            style: TextStyle(color: Colors.black, fontSize: 25.0)),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 25.0, 30.0, 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.description,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Divider(color: Colors.black, height: 3.0),
            SizedBox(height: 10.0),
            Text("${widget.createdTime} | ${widget.createdTime}"),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
