import 'package:flutter/material.dart';
import 'package:flutter_training/database/screens/user_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sqlite Storage',
      home: UserScreen(),
    );
  }
}
