class User {

  String? name;
  String? job;
  String? id;
  String? createdAt;

  User({this.name, this.job, this.id, this.createdAt});

  User.fromJson(dynamic json) {
    name = json['name'];
    job = json['job'];
    id = json['id'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['job'] = job;
    map['id'] = id;
    map['createdAt'] = createdAt;
    return map;
  }
}
