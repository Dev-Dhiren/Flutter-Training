import 'dart:convert';

import 'package:flutter_training/http/post/models/user.dart';
import 'package:http/http.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  String baseUrl = 'https://reqres.in/api/users';

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  Future<User?> addUser(String name, String job) async {
    try {
      var body = {'name': name, 'job': job};

      Response response = await post(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8', //Explicitly set content type and charset
        },
        Uri.parse(baseUrl),
        body: jsonEncode(body),

      );

      if (response.statusCode == 201) {
        // success
        return User.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
