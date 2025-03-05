class User {
  int? id;
  String name;
  String email;

  User({this.id, required this.name, required this.email});

  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'email': email};

  factory User.fromMap(Map<String, dynamic> map) =>
      User(id: map['id'], name: map['name'], email: map['email']);
}
