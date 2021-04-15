import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitch_emote/models/user.dart';

class SaveManagment {
  static saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    user.saveToSharedPreferences(prefs);
  }

  // Returns `null` if no User exists in storage
  static Future<User> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    return User.fromSavedPreferences(prefs);
  }
}
