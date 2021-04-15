import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/models/app_state.dart';
import 'package:twitch_emote/models/game_state.dart';
import 'package:twitch_emote/models/game_type.dart';
import 'package:twitch_emote/screens/game_screen.dart';
import 'package:twitch_emote/screens/login_screen.dart';
import 'package:twitch_emote/screens/no_connection_screen.dart';
import 'package:twitch_emote/screens/stats_screen.dart';
import 'package:twitch_emote/widgets/menu_button.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var homeState = context.watch<AppState>().homeState;
    switch (homeState) {
      case HomeState.LOADING:
        {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      case HomeState.LOGIN:
        {
          return LoginScreen();
        }
      case HomeState.NO_CONNECTION:
        {
          return NoConnectionScreen();
        }
      case HomeState.HOME:
        {
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
                      context.read<GameState>().type = GameType.TIME;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => GameScreen(type: GameType.TIME)));
                    },
                  ),
                  MenuButton(
                    name: "STREAK GAME",
                    onPressed: () {
                      context.read<GameState>().type = GameType.STREAK;
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => GameScreen(type: GameType.STREAK)));
                    },
                  ),
                  MenuButton(
                    name: "STATS",
                    onPressed: () {
                      context.read<GameState>().type = GameType.NONE;
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => StatsScreen()));
                    },
                  )
                ],
              ),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        }
    }
    return Container();
  }
}
