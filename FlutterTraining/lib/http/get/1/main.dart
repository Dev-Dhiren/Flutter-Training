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
  bool isLoading = true;

  List<User> userList = [];

  @override
  void initState() {
    super.initState();

    _loadUsers();
  }

  _setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Material App Bar')),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  var user = userList[index];

                  return ListTile(
                    leading: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text('${user.fName} ${user.lName}'),
                    subtitle: Text(user.email),
                  );
                },
              ),
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

      userList = userResponse.userList;

      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      print('Error : $e');
    }
  }
}
