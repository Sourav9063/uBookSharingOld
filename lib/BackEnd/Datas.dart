import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonThings {
  static Size size;
}

class UserDataSavedEmailPassword {
  static final String emailKey = 'UserEmail';
  static final String passwordKey = 'UserPassword';
  static final String isLoggedInKey = 'IsloggedIn';
    static final String uidKey = 'uidKey';

  // String getEmail() {
  //   return _email;
  // }

  // String getPassword() {
  //   return _password;
  // }

  static Future<bool> saveEmailSharedPref(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(emailKey, email);
  }

  static Future<String> getEmailSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }

    static Future<bool> saveuidSharedPref(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(uidKey, uid);
  }

  static Future<String> getuidSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(uidKey);
  }



  static Future<bool> savePasswordSharedPref(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(passwordKey, password);
  }

  static Future<String> getPasswordSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(passwordKey);
  }

  static Future<bool> saveIsLoggedInSharedPref(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(isLoggedInKey, isLoggedIn);
  }

  static Future<bool> getIsLoggedInSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey);
  }
}
