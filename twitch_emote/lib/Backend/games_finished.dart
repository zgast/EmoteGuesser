import 'dart:convert';

import 'package:http/http.dart' as http;

class games_finished {
  void streak(int count) async {
    await http.post(
      'http://10.0.2.2:8080/EmoteGuesser/game/streak/add',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'key':
            'usahd9720hd23807d23g2h8ofbgv24876fv24809fb2480fbn0ofhb<o83rg32ad78ashd8co89awhf9ofhaloifhf789obvaoisdzbvösadcvbasipf',
        'streak': count.toString(),
        'username': 'admin',
        'userID': '0001'
      }),
    );
  }
}
