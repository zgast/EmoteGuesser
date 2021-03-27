import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twitch_emote/Objects/Picture.dart';

class randomPic {
  static String name;
  static String URL;

  void get() async {
    final http.Response response = await http.post(
      'http://10.0.2.2:8080/EmoteGuesser/pictures/random',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'key':
            'usahd9720hd23807d23g2h8ofbgv24876fv24809fb2480fbn0ofhb<o83rg32ad78ashd8co89awhf9ofhaloifhf789obvaoisdzbvösadcvbasipf',
      }),
    );
    Picture picture = Picture.fromJson(jsonDecode(response.body));
    name = picture.name;
    URL = picture.URL;

    print(name);
    print(URL);
  }
}
