import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_user/src/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefsRepositoryProvider =
    Provider<SharedPrefsRepository>((ref) => SharedPrefsRepository());

class SharedPrefsRepository {
  final String _tokenKey = "LOAD DATABASE TOKEN";
  final String _darkModeKey = "Dark Mode";
  final _name = "SHARED_PREFS_REPO";

  Future<String?> getLoadDatabaseToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);

    log("Reading token", name: _name);
    log("Data : $token", name: _name);
    return token;
  }

  FutureVoid setLoadDatabaseToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    log("Saving token", name: _name);
    log("Data : $token", name: _name);

    prefs.setString(_tokenKey, token);
  }

  Future<String?> getDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_darkModeKey);

    log("Reading token", name: _name);
    log("Data : $token", name: _name);
    return token;
  }

  FutureVoid setDarkMode(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    log("Saving token", name: _name);
    log("Data : $token", name: _name);

    prefs.setString(_darkModeKey, token);
  }

  FutureVoid clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
