import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/GUI/Buttons.dart';
import 'package:twitch_emote/backend/GetStats.dart';
import 'package:twitch_emote/helper/Check.dart';
import 'package:twitch_emote/objects/User.dart';
import 'package:twitch_emote/objects/UserStats.dart';
import 'package:twitch_emote/widgets/HomescreenGUI.dart';

import 'NoConnectionGUI.dart';

class StatsGUI extends StatefulWidget {
  StatsGUI({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyStatsPage createState() => _MyStatsPage();
}

class _MyStatsPage extends State<StatsGUI> {
  String timeGame = "";
  String streakGame = "";
  var _username = User.name;
  void _start() async {
    if (!(await Check().checkConnection())) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => NoConnectionGUI()));
    }
    await _fetchData();
  }

  void _fetchData() async {
    UserStats userStats = await GetStatsRoute.getUserStats();
    var sg = userStats.streakGames;
    var sgg =
        (int.parse(userStats.streakGuessed) / int.parse(userStats.streakGames))
            .toStringAsFixed(2);
    var tg = userStats.timeGames;
    var tgg =
        (int.parse(userStats.timeGuessed) / int.parse(userStats.timeGames))
            .toStringAsFixed(2);
    setState(() {
      timeGame = "\nplayed: $tg    \navg. guessed: $tgg";
      streakGame = "\nplayed: $sg    \navg. guessed: $sgg ";
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Container(
              child: Text(
                "Stats from $_username :\n",
                textScaleFactor: 2,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Text(
                "TimeGame: $timeGame\n",
                textScaleFactor: 2,
              ),
            ),
            Container(
              child: Text(
                "StreakGame: $streakGame",
                textScaleFactor: 2,
              ),
            ),
            MenuButton(
              name: "BACK",
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => HomescreenGUI()));
              },
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
