import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twitch_emote/helper/SaveManagment.dart';
import 'package:twitch_emote/objects/User.dart';

class Login {
  Future<void> newUser(String name) async {
    final http.Response response = await http.post(
      'http://10.0.2.2:8080/EmoteGuesser/users/add',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'key':
            'usahd9720hd23807d23g2h8ofbgv24876fv24809fb2480fbn0ofhb<o83rg32ad78ashd8co89awhf9ofhaloifhf789obvaoisdzbvösadcvbasipf',
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
