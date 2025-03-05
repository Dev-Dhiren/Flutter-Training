import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredStorageService {
  static SecuredStorageService? _instance;
  late FlutterSecureStorage _storage;

  static final String _keyEmail = 'email';
  static final String _keyPassword = 'password';

  SecuredStorageService._internal(this._storage);

  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  static IOSOptions _getIOSOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  factory SecuredStorageService() {
    return _instance ??= SecuredStorageService._internal(
      FlutterSecureStorage(
        aOptions: _getAndroidOptions(),
        iOptions: _getIOSOptions(),
      ),
    );
  }

  Future<void> saveCredential(String email, String password) async {
    await _storage.write(key: _keyEmail, value: email);
    await _storage.write(key: _keyPassword, value: password);
  }

  Future<List<String?>> getCredential() async {
    String? email = await _storage.read(key: _keyEmail);
    String? password = await _storage.read(key: _keyPassword);

    return [email, password];
  }

  Future<void> clearCredential() async {
    await _storage.delete(key: _keyEmail);
    await _storage.delete(key: _keyPassword);
  }

}
