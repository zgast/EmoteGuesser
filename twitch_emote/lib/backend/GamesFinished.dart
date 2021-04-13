import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twitch_emote/backend/Key.dart';
import 'package:twitch_emote/objects/User.dart';

class gamesFinished {
  void post(int count, String game) async {
    String key = Key().API;
    String name = User.name;
    String ID = User.ID;
    Uri URL;
    if (game == "time") {
      URL = Uri.parse("https://api.zgast.at/EmoteGuesser/game/time/add/");
    } else {
      URL = Uri.parse("https://api.zgast.at/EmoteGuesser/game/streak/add/");
    }
    await http.post(
      URL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'key': '$key',
        'guessed': "$count",
        'username': "$name",
        'userID': "$ID",
      }),
    );
  }
}
