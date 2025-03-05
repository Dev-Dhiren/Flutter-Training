import 'package:flutter/material.dart';
import 'package:flutter_training/database/service/database_helper.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';

class TaskScreen extends StatefulWidget {
  int userId;

  TaskScreen({super.key, required this.userId});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  List<Task> tasks = [];
  DatabaseHelper db = DatabaseHelper();

  Future<void> _insertTask(String title, String description) async {
    var timeStamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    var task = Task(
      title: title,
      description: description,
      userId: widget.userId,
      createdAt: timeStamp,
    );

    var id = await db.addTask(task);

    if (id != -1) {
      print('Task added successfully.');
    }
  }

  @override
  void initState() {
    super.initState();

    _loadTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 16,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: "Enter Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: _descController,
                  decoration: InputDecoration(
                    labelText: "Enter Description",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String title = _titleController.text.trim();
              String description = _descController.text.trim();

              _insertTask(title, description);
            },
            child: Text("Add Task"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].title),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadTask() async {
    var list = await db.getTasks(widget.userId);
    tasks.clear();

    setState(() {
      tasks.addAll(list);
    });
  }
}
