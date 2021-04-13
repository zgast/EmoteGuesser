import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twitch_emote/backend/Key.dart';
import 'package:twitch_emote/objects/User.dart';
import 'package:twitch_emote/objects/UserStats.dart';

class GetStatsRoute {
  static Future<UserStats> getUserStats() async {
    String key = Key().API;
    String name = User.name;
    String ID = User.ID;
    final http.Response response = await http.post(
      Uri.parse('https://api.zgast.at//EmoteGuesser/stats/user/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'key': '$key',
        'username': "$name",
        'userID': "$ID",
      }),
    );

    return UserStats.fromJson(jsonDecode(response.body));
  }
}
