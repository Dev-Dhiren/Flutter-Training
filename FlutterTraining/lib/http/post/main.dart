import 'package:flutter/material.dart';
import 'package:flutter_training/http/post/service/api_service.dart';

import '../../http/post/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: AccountScreen());
  }
}

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _nameController = TextEditingController();
  final _jobController = TextEditingController();

  final ApiService _service = ApiService();

  Future<void> _addUser(String name, String job) async {
    User? user = await _service.addUser(name, job);

    if(user!=null){
      print('${user.toJson()}');
      print('User created successfully');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Authentication')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Name',
                ),
              ),
              TextField(
                controller: _jobController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Name',
                ),
              ),
              Container(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    String name = _nameController.text.trim();
                    String job = _jobController.text.trim();

                    _addUser(name, job);
                  },
                  child: Text('Create Account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
