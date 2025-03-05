import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_training/sharedpreferences/model/user.dart';
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

  User? user;

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
          user == null
              ? SizedBox.shrink()
              : Center(
                child: Text('''
        First Name : ${user?.fName}
        Last Name : ${user?.lName}
        Email : ${user?.email}
        Age : ${user?.age}
        Salary : ${user?.salary}
        
        '''),
              ),
    );
  }

  Future<void> _loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      setState(() {
        /*fName = preferences.getString('FNAME') ?? 'No Data';
        lName = preferences.getString('LNAME') ?? 'No Data';
        age = preferences.getInt('AGE') ?? 0;
        salary = preferences.getDouble('SALARY') ?? 0.0;
        email = preferences.getString('EMAIL') ?? 'No Data';*/

        var json = preferences.getString("USER") ?? '';

        print('json : $json');
        print(
          'jsonDecode : ${jsonDecode(json)}',
        ); // convert json string into map

        user = User.fromJson(jsonDecode(json));
      });
    } catch (e) {
      print(e);
    }
  }
}
