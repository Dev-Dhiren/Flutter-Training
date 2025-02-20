import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_training/sharedpreferences_singlton/model/person.dart';
import 'package:flutter_training/sharedpreferences_singlton/preferences/pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  /*String fName = '', lName = '', email = '';
  int age = 0;
  double salary = 0.0;*/

  Person? person;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Screen')),
      body:
          person == null
              ? SizedBox.shrink()
              : Center(
                child: Text('''
        First Name : ${person?.fName}
        Last Name : ${person?.lName}
        Email : ${person?.email}
        Age : ${person?.age}
        Salary : ${person?.salary}
        
        '''),
              ),
    );
  }

  _loadData() {

    var manager = PrefManager();
    person  = manager.getPerson();
  }
}
