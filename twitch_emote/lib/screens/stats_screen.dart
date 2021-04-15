import 'package:flutter/material.dart';
import 'package:twitch_emote/backend/api_wrapper.dart';
import 'package:twitch_emote/models/app_state.dart';

import 'package:provider/provider.dart';
import 'package:twitch_emote/widgets/menu_button.dart';

class StatsScreen extends StatefulWidget {
  StatsScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  String _timeGame = "";
  String _streakGame = "";
  String _username = "";

  @override
  void initState() {
    _initScreen();
    super.initState();
  }

  _initScreen() async {
    context.read<AppState>().checkConnection();
    var user = context.read<AppState>().loggedInUser;
    _username = user.name;
    var stats = await ApiWrapper.instance.getUserStats(user);

    // Can't call setState before first build --> Add PostFrameCallback
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        if (stats == null) {
          _timeGame = "\nERROR WHILE LOADING";
          _streakGame = "\nERROR WHILE LOADING";
        }

        _timeGame =
            "\nplayed: ${stats.timeGames} \navg. guessed: ${(int.parse(stats.timeGuessed) / int.parse(stats.timeGames)).toStringAsFixed(2)}";
        _streakGame =
            "\nplayed: ${stats.streakGames}    \navg. guessed: ${(int.parse(stats.streakGuessed) / int.parse(stats.streakGames)).toStringAsFixed(2)} ";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                "Stats for $_username:\n",
                textScaleFactor: 2,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Text(
                "TimeGame: $_timeGame\n",
                textScaleFactor: 2,
              ),
            ),
            Container(
              child: Text(
                "StreakGame: $_streakGame",
                textScaleFactor: 2,
              ),
            ),
            MenuButton(
              name: "BACK",
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
