import 'dart:convert';

import 'package:flutter_training/http/practical/models/token.dart';
import 'package:flutter_training/http/practical/models/user.dart';
import 'package:flutter_training/http/practical/utils/app_constant.dart';
import 'package:http/http.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  // Login User and get access token
  loginUser({
    required String email,
    required String password,
    required Function(Token) onSuccess,
    required Function(String) onError,
  }) {
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    var body = {'email': email, 'password': password};

    try {
      post(Uri.parse(loginUrl), body: jsonEncode(body), headers: headers).then((
        res,
      ) {
        if (res.statusCode == 201) {
          onSuccess(Token.fromJson(jsonDecode(res.body)));

        } else {
          var error = _parseErrorMessage(jsonDecode(res.body));
          onError(error);
        }
      });
    } catch (e) {
      onError('Error : ${e.toString()}');
    }
  }

  // Register Account
  createAccount({
    required String name,
    required String email,
    required String password,
    required Function(User) onSuccess,
    required Function(String) onError,
  }) async {
    /*  User user = User(
      name: name,
      email: email,
      password: password,
      avatar: 'https://api.lorem.space/image/face?w=640&h=480',
    );*/

    // print('map : ${user.toJson()}');
    // print('json : ${jsonEncode(user.toJson())}');

    var body = {
      "name": name,
      "email": email,
      "password": password,
      "avatar": "https://api.lorem.space/image/face?w=640&h=480",
    };

    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      //Explicitly set content type and charset
    };

    try {
      Response response = await post(
        Uri.parse(registerUrl),
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 201) {
        User user = User.fromJson(jsonDecode(response.body));
        onSuccess(user);
      } else {
        var error = _parseErrorMessage(jsonDecode(response.body));
        onError(error);
      }
    } catch (e) {
      onError('Error : ${e.toString()}');
    }

    /* {
      "message": [
    "password must be longer than or equal to 4 characters",
    "password should not be empty",
    "password must contain only letters and numbers"
    ],
    "error": "Bad Request",
    "statusCode": 400
  }*/
  }

  String _parseErrorMessage(Map<String, dynamic> errorResponse) {
    if (errorResponse.containsKey('message')) {
      if (errorResponse['message'] is List) {
        return (errorResponse['message'] as List).join(', ');
      } else {
        return errorResponse['message'];
      }
    } else {
      return 'Unknown error';
    }
  }
}
