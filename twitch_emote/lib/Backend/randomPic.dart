import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twitch_emote/Objects/Picture.dart';

class randomPic {
  Future<Picture> get() async {
    print("asdasd");
    final http.Response response = await http.post(
      'http://localhost:8080/EmoteGuesser/pictures/random',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'key':
            'usahd9720hd23807d23g2h8ofbgv24876fv24809fb2480fbn0ofhb<o83rg32ad78ashd8co89awhf9ofhaloifhf789obvaoisdzbvösadcvbasipf',
      }),
    );
    print(Picture.fromJson(jsonDecode(response.body)).getName());

    return Picture.fromJson(jsonDecode(response.body));
  }
}
