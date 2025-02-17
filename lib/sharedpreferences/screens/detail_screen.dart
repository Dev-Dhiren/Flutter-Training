import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String fName = '', lName = '', email = '';
  int age = 0;
  double salary = 0.0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Screen')),
      body: Center(
        child: Text('''
        First Name : $fName
        Last Name : $lName
        Email : $email
        Age : $age
        Salary : $salary
        
        '''),
      ),
    );
  }

  Future<void> _loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      setState(() {
        fName = preferences.getString('FNAME') ?? 'No Data';
        lName = preferences.getString('LNAME') ?? 'No Data';
        age = preferences.getInt('AGE') ?? 0;
        salary = preferences.getDouble('SALARY') ?? 0.0;
        email = preferences.getString('EMAIL') ?? 'No Data';
      });
    } catch (e) {
      print(e);
    }
  }
}
