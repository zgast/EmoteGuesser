import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/GUI/buttons.dart';

import 'file:///C:/Users/Markus/Documents/GitHub/EmoteGuesser/twitch_emote/lib/widgets/no_connection.dart';
import 'file:///C:/Users/Markus/Documents/GitHub/EmoteGuesser/twitch_emote/lib/widgets/streak%20_gui.dart';
import 'file:///C:/Users/Markus/Documents/GitHub/EmoteGuesser/twitch_emote/lib/widgets/time_gui.dart';

import '../helper/check.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  streak_count _counter = new streak_count();
  void _checkConnection() async {
    if (!(await check().checkConnection())) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => no_connection_GUI()));
    }
  }

  @override
  Widget build(BuildContext context) {
    _counter(false, true);
    _checkConnection();
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
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => GuessGUI()));
              },
            ),
            MenuButton(
              name: "STREAK GAME",
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => streak_gui()));
              },
            ),
            MenuButton(
              name: "STATS",
              onPressed: () {},
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
