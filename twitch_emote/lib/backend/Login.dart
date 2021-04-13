import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twitch_emote/backend/Key.dart';
import 'package:twitch_emote/helper/SaveManagment.dart';
import 'package:twitch_emote/objects/User.dart';

class Login {
  Future<void> newUser(String name) async {
    String key = Key().API;
    final http.Response response = await http.post(
      Uri.parse('https://api.zgast.at/EmoteGuesser/users/add/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'key': '$key',
        'username': '$name',
      }),
    );

    Map<String, dynamic> json = jsonDecode(response.body);
    User.ID = json["userID"];
    User.token = json["token"];
    User.name = name;

    SaveManagment().save();
  }
}
