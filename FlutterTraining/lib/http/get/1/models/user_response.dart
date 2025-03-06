import 'dart:convert';

class UserResponse {
  int page;
  int perPage;
  int total;
  int totalPages;
  Support support;
  List<User> userList;

  UserResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.support,
    required this.userList,
  });

  factory UserResponse.fromJson(Map<String, dynamic> map) {
    var userList = map['data'] as List;

    return UserResponse(
      page: map['page'] as int,
      perPage: map['per_page'] as int,
      total: map['total'] as int,
      totalPages: map['total_pages'] as int,
      support: Support.fromJson(map['support']),
      userList: userList.map((e) => User.fromJson(e)).toList(),
    );
  }
}

class Support {
  String url;
  String text;

  Support({required this.url, required this.text});

  factory Support.fromJson(Map<String, dynamic> map) {
    return Support(url: map['url'] as String, text: map['text'] as String);
  }
}

class User {
  int id;
  String fName;
  String lName;
  String email;
  String avatar;

  User({
    required this.id,
    required this.fName,
    required this.lName,
    required this.email,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      fName: map['first_name'] as String,
      lName: map['last_name'] as String,
      email: map['email'] as String,
      avatar: map['avatar'] as String,
    );
  }
}
