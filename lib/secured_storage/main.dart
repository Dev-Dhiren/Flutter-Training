import 'package:flutter/material.dart';
import 'package:flutter_training/secured_storage/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: LoginScreen());
  }
}
