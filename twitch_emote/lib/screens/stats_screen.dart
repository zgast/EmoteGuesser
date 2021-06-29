import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_emote/backend/api_wrapper.dart';
import 'package:twitch_emote/models/app_state.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 50, 0, 0),
            width: double.maxFinite,
            child: Text(
              'Streakgame',
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.deepPurple),
            ),
          ),
          const Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
            color: Colors.deepPurple,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            width: double.maxFinite,
            child: Text(
              "GAMES PLAYED:",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            width: double.maxFinite,
            child: Text(
              "234",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            width: double.maxFinite,
            child: Text(
              "AVERAGE GUESSED:",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            width: double.maxFinite,
            child: Text(
              "234",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            width: double.maxFinite,
            child: Text(
              "GLOBAL RANK:",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            width: double.maxFinite,
            child: Text(
              "#2",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
            width: double.maxFinite,
            child: Text(
              'Timegame',
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.deepPurple),
            ),
          ),
          const Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
            color: Colors.deepPurple,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            width: double.maxFinite,
            child: Text(
              "GAMES PLAYED:",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            width: double.maxFinite,
            child: Text(
              "234",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            width: double.maxFinite,
            child: Text(
              "AVERAGE GUESSED:",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            width: double.maxFinite,
            child: Text(
              "234",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            width: double.maxFinite,
            child: Text(
              "GLOBAL RANK:",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            width: double.maxFinite,
            child: Text(
              "#2",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
