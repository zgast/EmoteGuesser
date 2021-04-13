import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twitch_emote/backend/Key.dart';

class randomPic {
  String key = Key().API;
  static String name;
  static String URL;

  void get() async {
    final http.Response response = await http.post(
      Uri.parse('https://api.zgast.at/EmoteGuesser/pictures/random/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'key': '$key',
      }),
    );

    Map<String, dynamic> json = jsonDecode(response.body);
    name = json["name"];
    URL = json["url"];
  }
}
