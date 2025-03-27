import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_training/http/practical/models/token.dart';

class StorageService {
  static StorageService? _instance;
  late FlutterSecureStorage _storage;

  static final String _keyToken = 'token';
  static final String _keyIsLogin = 'isLogin';

  StorageService._internal(this._storage);

  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  static IOSOptions _getIOSOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  factory StorageService() {
    return _instance ??= StorageService._internal(
      FlutterSecureStorage(
        aOptions: _getAndroidOptions(),
        iOptions: _getIOSOptions(),
      ),
    );
  }

  // save access and refresh token
  Future<void> saveToken(Token token) async {
    await _storage.write(key: _keyToken, value: jsonEncode(token.toJson()));
  }

  // get access and refresh token
  Future<Token?> getToken() async {
    String? jsonString = await _storage.read(key: _keyToken);
    if (jsonString == null) {
      return null;
    } else {
      return Token.fromJson(jsonDecode(jsonString));
    }
  }

  // set login status
  Future<void> setLoginStatus(bool status) async {
    await _storage.write(key: _keyIsLogin, value: status.toString());
  }

  // get login status
  Future<bool> getLoginStatus() async {
    String? status = await _storage.read(key: _keyIsLogin);

    if (status == null) {
      return false;
    } else {
      if (status == 'true') {
        return true;
      } else {
        return false;
      }
    }
  }

  // clear data
  Future<void> clearData() async {
    await _storage.delete(key: _keyToken);
    await _storage.delete(key: _keyIsLogin);
  }
}
