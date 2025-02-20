// this class will contains all members and methods related to preference storage

/*
*   Step to create Singleton Class
*   1. create a named constructor (ex. _internal)
*   2. create an object by using this named constructor
*   3. create a factory constructor which returns that instance.
* */

import 'dart:convert';

import 'package:flutter_training/sharedpreferences_singlton/model/person.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  static final _keyPerson = 'person';

  static final PrefManager _instance = PrefManager._internal();
  SharedPreferences? _preferences;

  // creating named constructor
  PrefManager._internal();

  // factory constructor
  factory PrefManager() {
    return _instance;
  }

  // it initialize the preference object
  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  // save person
  Future<bool> savePerson(Person person) async {
    try {
      await _preferences?.setString(_keyPerson, jsonEncode(person.toJson()));
      return true;
    } catch (e) {
      return false;
    }
  }

  Person? getPerson() {
    Person? person;

    try {
      String? jsonString = _preferences?.getString(_keyPerson);

      if (jsonString != null) {
        print('jsonString : $jsonString');

        person = Person.fromJson(jsonDecode(jsonString));
        return person;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
