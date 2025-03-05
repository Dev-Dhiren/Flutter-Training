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
  void initState() {
    super.initState();

    _loadUser();
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _emailController.dispose();
  }

  Future<void> _insertUser(String name, String email) async {
    User user = User(name: name, email: email);

    /* var result = await db.addUser(user);
    print('result : $result');
    if (result != -1) {
      _nameController.clear();
      _emailController.text = "";
      print('User added successfully..');
    } else {
      print('Error : while inserting');
    }*/
    db.addUser(
      user: user,
      onSuccess: (User user) {
        setState(() {
          users.add(user);
          print('User added successfully..');
        });
      },
      onError: (error) {
        print(error);
      },
    );
  }

  _editUser(User user) {
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);

    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 16,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "User name",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Row(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton.tonal(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      FilledButton(
                        onPressed: () async {
                          String name = nameController.text.trim();
                          String email = emailController.text.trim();

                          var mUser = User(
                            name: name,
                            email: email,
                            id: user.id,
                          );

                          var result = await db.updateUser(mUser);

                          print('result : $result');

                          if (result > 0) {
                            var index = users.indexWhere(
                              (element) => element.id == mUser.id,
                            );

                            if (index != -1) {
                              setState(() {
                                users[index] = mUser;
                              });
                            }
                          }

                          Navigator.pop(context);

                          // _loadUser();
                        },
                        child: Text('Update'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
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
                  User user = users[index];

                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            _editUser(user);
                          },
                          icon: Icon(Icons.edit, color: Colors.grey),
                        ),
                        IconButton(
                          onPressed: () async {
                            var result = await db.deleteUser(user.id!);

                            if (result > 0) {
                              setState(() {
                                users.removeAt(index);
                              });
                            }

                            print('result : $result');
                            // _loadUser();
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskScreen(userId: user.id!),
                        ),
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

  Future<void> _loadUser() async {
    var list = await db.getUsers();
    setState(() {
      users.clear();
      users.addAll(list);
    });
  }
}
