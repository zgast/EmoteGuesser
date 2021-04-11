import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/Backend/GamesFinished.dart';
import 'package:twitch_emote/Backend/RandomPic.dart';
import 'package:twitch_emote/GUI/Buttons.dart';
import 'package:twitch_emote/helper/GuesserCounter.dart';
import 'package:twitch_emote/helper/SaveManagment.dart';
import 'package:twitch_emote/widgets/LoginGUI.dart';
import 'package:twitch_emote/widgets/NoConnectionGUI.dart';
import 'package:twitch_emote/widgets/StatsGUI.dart';
import 'package:twitch_emote/widgets/StreakGUI.dart';
import 'package:twitch_emote/widgets/TimeGameGUI.dart';

import '../helper/Check.dart';

class HomescreenGUI extends StatefulWidget {
  HomescreenGUI({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomescreenGUIState createState() => _HomescreenGUIState();
}

class _HomescreenGUIState extends State<HomescreenGUI> {
  static String _game = "null";
  var _counter = new guesserCounter();
  void _start() async {
    if (!(await SaveManagment().load())) {
      _game = "null";
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginGUI()));
    }
    if (!(await Check().checkConnection())) {
      _game = "null";
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => NoConnectionGUI()));
    }
    await randomPic().get();
  }

  void _stats() async {
    if (_game != "null") {
      gamesFinished().post(guesserCounter.count, _game);
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
                    MaterialPageRoute(builder: (_) => TimeGameGUI()));
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
                    MaterialPageRoute(builder: (_) => StatsGUI()));
              },
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
