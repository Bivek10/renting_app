import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class updatebook extends StatefulWidget {
  String? userId;
  String? bookId;
  String? name;
  String? description;
  String? createdDate;
  String? createdTime;
  updatebook({
    Key? key,
    required this.userId,
    required this.bookId,
    required this.name,
    required this.description,
    required this.createdDate,
    required this.createdTime,
  }) : super(key: key);

  @override
  State<updatebook> createState() => _updatebookState();
}

class _updatebookState extends State<updatebook> {
  String? _setTime, _setDate;

  String? _hour, _minute, _time;

  String? dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = '${_hour!} : ${_minute!}';
        _timeController.text = _time!;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        elevation: 0.0,
        title: Text(
          'Update Book',
          style: TextStyle(color: Colors.blue, fontSize: 30.0),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.blue)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),
              TextField(
                textInputAction: TextInputAction.next,
                controller: _nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Username',
                    hintText: 'Enter your name........'),
              ),
              SizedBox(height: 20.0),
              TextField(
                textInputAction: TextInputAction.next,
                controller: _descriptionController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Enter your vehicle type ',
                    hintText: 'Enter of your vehicle type needed........'),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Enter Modify Date',
                    hintText: 'Enter modify date of your note........'),
                onTap: () {
                  _selectDate(context);
                },
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _timeController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Enter Modify Time',
                    hintText: 'Enter modify time of your note........'),
                onTap: () {
                  _selectTime(context);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  print(widget.bookId);
                  updateUser(
                    _nameController.text,
                    _descriptionController.text,
                    _dateController.text,
                    _timeController.text,
                  );
                },
                child: Text('Update Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateUser(name, description, date, time) {
    return FirebaseFirestore.instance
        .doc('users/${widget.userId}/books/${widget.bookId}')
        .update({
          'title': name,
          'description': description,
          'updatedDate': date,
          'updatedTime': time,
          'username': _nameController.text.trim(),
        })
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to update user: $error"));
  }

  getBookID() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('books')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print("Book ID: ${element.id}");
      });
    });
  }
}
