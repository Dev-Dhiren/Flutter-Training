import 'package:flutter/material.dart';
import 'package:flutter_training/sharedpreferences/screens/form_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: FormScreen(),
    );
  }
}
