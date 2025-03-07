class Album {
  int userId;
  int id;
  String title;

  Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> map) {
    return Album(userId: map['userId'], id: map['id'], title: map['title']);
  }
}
