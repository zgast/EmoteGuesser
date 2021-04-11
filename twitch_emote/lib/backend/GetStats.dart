import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twitch_emote/objects/User.dart';
import 'package:twitch_emote/objects/UserStats.dart';

class GetStatsRoute {
  static Future<UserStats> getUserStats() async {
    String name = User.name;
    String ID = User.ID;
    final http.Response response = await http.post(
      'http://10.0.2.2:8080/EmoteGuesser/stats/user',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'key':
            'usahd9720hd23807d23g2h8ofbgv24876fv24809fb2480fbn0ofhb<o83rg32ad78ashd8co89awhf9ofhaloifhf789obvaoisdzbvösadcvbasipf',
        'username': "$name",
        'userID': "$ID",
      }),
    );

    return UserStats.fromJson(jsonDecode(response.body));
  }
}
