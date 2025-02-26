class Task {
  int? id;
  String title;
  String description;
  int userId;
  String createdAt;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'userId': userId,
    'description': description,
    'createdAt': createdAt,
  };

  factory Task.fromMap(Map<String, dynamic> map) => Task(
    id: map['id'],
    title: map['title'],
    userId: map['userId'],
    description: map['description'],
    createdAt: map['createdAt'],
  );
}
