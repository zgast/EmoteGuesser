import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/GUI/buttons.dart';
import 'package:twitch_emote/helper/check.dart';
import 'package:twitch_emote/widgets/homescreen.dart';

import 'no_connection.dart';

class StatsPage extends StatefulWidget {
  StatsPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyStatsPage createState() => _MyStatsPage();
}

class _MyStatsPage extends State<StatsPage> {
  var _username = "admin";
  void _start() async {
    if (!(await check().checkConnection())) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => no_connection_GUI()));
    }
  }

  void _fetchData() async {}

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
              "Stats from $_username :",
              textScaleFactor: 2,
            )),
            MenuButton(
              name: "BACK",
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => MyHomePage()));
              },
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
