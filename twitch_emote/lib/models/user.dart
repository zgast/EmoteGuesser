import 'package:shared_preferences/shared_preferences.dart';

class User {
  String name;
  String id;
  String token;

  User(this.name, this.id, this.token);

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(json["name"], json["userID"], json["token"]);
    } catch (e) {
      return null;
    }
  }

  static const idKey = 'userID';
  static const nameKey = 'username';
  static const tokenKey = 'token';
  factory User.fromSavedPreferences(SharedPreferences prefs) {
    String id = prefs.getString(idKey);
    if (id == null) {
      return null;
    }
    String name = prefs.getString(nameKey);
    if (name == null) {
      return null;
    }
    String token = prefs.getString(tokenKey);
    if (token == null) {
      return null;
    }
    return User(name, id, token);
  }

  saveToSharedPreferences(SharedPreferences prefs) async {
    await prefs.setString(idKey, id);
    await prefs.setString(nameKey, name);
    await prefs.setString(tokenKey, token);
  }
}
