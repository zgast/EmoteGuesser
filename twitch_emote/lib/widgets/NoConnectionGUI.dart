import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/GUI/Buttons.dart';
import 'package:twitch_emote/helper/Check.dart';
import 'package:twitch_emote/widgets/HomescreenGUI.dart';

class NoConnectionGUI extends StatefulWidget {
  @override
  _NoConnectionGUIState createState() => _NoConnectionGUIState();
}

class _NoConnectionGUIState extends State<NoConnectionGUI> {
  void _checkConnection() async {
    if (!(await Check().checkConnection())) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomescreenGUI()));
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
