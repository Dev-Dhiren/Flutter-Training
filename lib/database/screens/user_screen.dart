import 'package:flutter/material.dart';
import 'package:flutter_training/database/service/database_helper.dart';

import '../models/user.dart';
import 'task_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  List<User> users = [];

  DatabaseHelper db = DatabaseHelper();

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _emailController.dispose();
  }

  void _insertUser(String name, String email) {
    User user = User(name: name, email: email);

    db.addUser(user);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "User name",
                border: OutlineInputBorder(),
              ),
            ),

            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email address",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String name = _nameController.text.trim();
                  String email = _emailController.text.trim();

                  _insertUser(name, email);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
                child: Text("Add User"),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(users[index].name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TaskScreen()),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
