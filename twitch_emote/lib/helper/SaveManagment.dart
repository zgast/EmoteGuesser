import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitch_emote/objects/User.dart';

class SaveManagment {
  save() async {
    final prefs = await SharedPreferences.getInstance();
    var key = 'userID';
    var value = User.ID;
    prefs.setString(key, value);
    key = 'username';
    value = User.name;
    prefs.setString(key, value);
    key = 'token';
    value = User.token;
    prefs.setString(key, value);
  }

  Future<bool> load() async {
    final prefs = await SharedPreferences.getInstance();
    var key = 'userID';
    var value = prefs.getString(key);
    if (value != null) {
      User.ID = value as String;
    } else {
      return false;
    }
    key = 'username';
    value = prefs.getString(key);
    if (value != null) {
      User.name = value as String;
    } else {
      return false;
    }
    key = 'token';
    value = prefs.getString(key);
    if (value != null) {
      User.token = value as String;
    } else {
      return false;
    }
    return true;
  }
}
