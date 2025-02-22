class Task {
  int? id;
  String title;
  int userId;

  Task({this.id, required this.title, required this.userId});

  Map<String, dynamic> toMap() => {'id': id, 'title': title, 'userId': userId};

  factory Task.fromMap(Map<String, dynamic> map) =>
      Task(id: map['id'], title: map['title'], userId: map['userId']);
}
