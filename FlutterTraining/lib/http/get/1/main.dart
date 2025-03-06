import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_training/http/get/1/models/user_response.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: UserScreen());
  }
}

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String url = 'https://reqres.in/api/users?page=1';

  @override
  void initState() {
    super.initState();

    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Material App Bar')),
      body: Center(child: Container(child: Text('Hello World'))),
    );
  }

  Future<void> _loadUsers() async {
    // sending request to server
    try {
      http.Response res = await http.get(Uri.parse(url));

      print('status code : ${res.statusCode}');
      print('response body : ${res.body}');

      UserResponse userResponse = UserResponse.fromJson(jsonDecode(res.body));
      print('user response : $userResponse');

    } catch (e) {
      print('Error : $e');
    }
  }
}
