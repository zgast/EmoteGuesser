import 'package:shared_preferences/shared_preferences.dart';

class User {
  String name;
  String id;
  String jwt;

  User(this.name, this.id, this.jwt);

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(json["name"], json["userID"], json["jwt"]);
    } catch (e) {
      return null;
    }
  }

  static const idKey = 'userID';
  static const nameKey = 'username';
  static const jwtKey = 'jwt';
  factory User.fromSavedPreferences(SharedPreferences prefs) {
    String id = prefs.getString(idKey);
    if (id == null) {
      return null;
    }
    String name = prefs.getString(nameKey);
    if (name == null) {
      return null;
    }
    String token = prefs.getString(jwtKey);
    if (token == null) {
      return null;
    }
    return User(name, id, token);
  }

  saveToSharedPreferences(SharedPreferences prefs) async {
    await prefs.setString(idKey, id);
    await prefs.setString(nameKey, name);
    await prefs.setString(jwtKey, jwt);
  }
}
