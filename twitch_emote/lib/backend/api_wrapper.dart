import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twitch_emote/backend/api_key.dart';
import 'package:twitch_emote/helper/save_managment.dart';
import 'package:twitch_emote/models/emote_pic.dart';
import 'package:twitch_emote/models/game_type.dart';
import 'package:twitch_emote/models/user.dart';
import 'package:twitch_emote/models/user_stats.dart';

// Create ApiWrapper Singleton
class ApiWrapper {
  static final instance = ApiWrapper._();

  ApiWrapper._();

  static const baseUrl = 'https://api.zgast.at/emote-guesser/v1';

  Future finishGame(int count, GameType game, User user) async {
    Uri uri;

    switch (game) {
      case GameType.TIME:
        {
          uri = Uri.parse('$baseUrl/game/time/add');
          break;
        }
      case GameType.STREAK:
        {
          uri = Uri.parse('$baseUrl/game/streak/add');
          break;
        }
      case GameType.NONE:
        {
          return;
        }
    }
    await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': '$apiKey'
      },
      body: jsonEncode(
          <String, String>{'guessed': "$count", 'jwt': "${user.jwt}"}),
    );
  }

  Future<UserStats> getUserStats(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/stats/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': '$apiKey',
      },
      body: jsonEncode(<String, String>{'jwt': "${user.jwt}"}),
    );

    return UserStats.fromJson(jsonDecode(response.body));
  }

  Future<User> registerUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': '$apiKey',
      },
      body: jsonEncode(<String, String>{
        'username': '$username',
        'password': '$password',
      }),
    );

    if (response.statusCode == 500) return null;
    Map<String, dynamic> json = jsonDecode(response.body);
    User user = User.fromJson(json);
    await SaveManagment.saveUser(user);

    return user;
  }

  Future<User> loginUser(
      String username, String userID, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': '$apiKey',
      },
      body: jsonEncode(<String, String>{
        'userID': '$userID',
        'username': '$username',
        'password': '$password',
      }),
    );

    if (response.statusCode == 500) return null;
    Map<String, dynamic> json = jsonDecode(response.body);
    User user = User.fromJson(json);
    await SaveManagment.saveUser(user);

    return user;
  }

  Future<EmotePic> getRandomPic() async {
    final response = await http.post(
      Uri.parse('$baseUrl/pictures/random'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': '$apiKey',
      },
      body: jsonEncode(<String, String>{}),
    );

    Map<String, dynamic> json = jsonDecode(response.body);
    return EmotePic.fromJson(json);
  }
}
