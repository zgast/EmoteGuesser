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
  var timePlayed = "loading...",
      timeAvg = "loading...",
      timeRank = "loading...",
      streakPlayed = "loading...",
      streakAvg = "loading...",
      streakRank = "loading...";

  @override
  void initState() {
    _initScreen();
    super.initState();
  }

  _initScreen() async {
    context.read<AppState>().checkConnection();
    var user = context.read<AppState>().loggedInUser;
    var stats = await ApiWrapper.instance.getUserStats(user);

    // Can't call setState before first build --> Add PostFrameCallback
    setState(() {
      if (stats != null) {
        timePlayed = stats.timeGames;
        timeAvg =
            "${(int.parse(stats.timeGuessed) / int.parse(stats.timeGames)).toStringAsFixed(2)}";
        streakPlayed = stats.streakGames;
        streakAvg =
            "${(int.parse(stats.streakGuessed) / int.parse(stats.streakGames)).toStringAsFixed(2)} ";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                  10, MediaQuery.of(context).size.height / 17, 10, 0),
              height: 280 + MediaQuery.of(context).size.height / 20,
              width: double.maxFinite,
              child: Card(
                elevation: 15,
                shadowColor: Colors.deepPurple,
                color: Colors.deepPurple,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Text(
                        'Streakgame',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      width: double.maxFinite,
                      child: Text(
                        "$streakPlayed",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      width: double.maxFinite,
                      child: Text(
                        "$streakAvg",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      width: double.maxFinite,
                      child: Text(
                        "$streakRank",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  10, MediaQuery.of(context).size.height / 40, 10, 0),
              height: 280 + MediaQuery.of(context).size.height / 50,
              width: double.maxFinite,
              child: Card(
                elevation: 15,
                shadowColor: Colors.deepPurple,
                color: Colors.deepPurple,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Text(
                        'Timegame',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
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
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      width: double.maxFinite,
                      child: Text(
                        "$timePlayed",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      width: double.maxFinite,
                      child: Text(
                        "$timeAvg",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      width: double.maxFinite,
                      child: Text(
                        "$timeRank",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
