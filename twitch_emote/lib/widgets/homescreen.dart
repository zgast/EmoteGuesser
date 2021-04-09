import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/Backend/games_finished.dart';
import 'package:twitch_emote/Backend/randomPic.dart';
import 'package:twitch_emote/GUI/buttons.dart';
import 'package:twitch_emote/helper/guesser_counter.dart';
import 'package:twitch_emote/widgets/stats.dart';
import 'package:twitch_emote/widgets/streak_gui.dart';

import 'file:///C:/Users/Markus/Documents/GitHub/EmoteGuesser/twitch_emote/lib/widgets/no_connection.dart';
import 'file:///C:/Users/Markus/Documents/GitHub/EmoteGuesser/twitch_emote/lib/widgets/time_gui.dart';

import '../helper/check.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static String _game = "null";
  var _counter = new guessed_counter();
  void _start() async {
    if (!(await check().checkConnection())) {
      _game = "null";
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => no_connection_GUI()));
    }
    await randomPic().get();
  }

  void _stats() async {
    if (_game != "null") {
      games_finished().post(guessed_counter.count, _game);
    }
    _counter(false, true);
  }

  @override
  Widget build(BuildContext context) {
    _stats();
    _start();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: new EdgeInsets.only(bottom: 30),
              child: Image.network(
                'https://data.zgast.at/EmoteGuesser/Transparent_Icon.png',
                width: 200,
                height: 200,
              ),
            ),
            MenuButton(
              name: "TIME GAME",
              onPressed: () {
                _game = "time";
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => GuessGUI()));
              },
            ),
            MenuButton(
              name: "STREAK GAME",
              onPressed: () {
                _game = "streak";
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => StreakGUI()));
              },
            ),
            MenuButton(
              name: "STATS",
              onPressed: () {
                _game = "null";
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => StatsPage()));
              },
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
