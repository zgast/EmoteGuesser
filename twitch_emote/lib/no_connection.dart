import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/GUI/buttons.dart';
import 'package:twitch_emote/helper/check.dart';
import 'package:twitch_emote/homescreen.dart';

class no_connection_GUI extends StatefulWidget {
  @override
  _no_connection_GUIState createState() => _no_connection_GUIState();
}

class _no_connection_GUIState extends State<no_connection_GUI> {
  void _checkConnection() async {
    if ((await check().checkConnection())) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => MyHomePage()));
    }
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
              margin: new EdgeInsets.only(top: 300),
              child: Text(
                'Sry, no network connection!',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              margin: new EdgeInsets.only(top: 200, bottom: 40),
              child: MenuButton(
                onPressed: () {
                  _checkConnection();
                },
                name: "Retry",
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
