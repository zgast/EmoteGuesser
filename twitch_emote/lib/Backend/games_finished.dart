import 'dart:convert';

import 'package:http/http.dart' as http;

class games_finished {
  void post(int count, String game) async {
    String URL;
    if (game == "time") {
      URL = "http://10.0.2.2:8080/EmoteGuesser/game/time/add";
    } else {
      URL = "http://10.0.2.2:8080/EmoteGuesser/game/streak/add";
    }
    await http.post(
      URL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'key':
            'usahd9720hd23807d23g2h8ofbgv24876fv24809fb2480fbn0ofhb<o83rg32ad78ashd8co89awhf9ofhaloifhf789obvaoisdzbvösadcvbasipf',
        'guessed': "$count",
        'username': 'admin',
        'userID': "0001",
      }),
    );
  }
}
