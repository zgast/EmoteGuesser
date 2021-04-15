import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/models/app_state.dart';
import 'package:twitch_emote/widgets/menu_button.dart';

import 'package:provider/provider.dart';

class NoConnectionScreen extends StatefulWidget {
  @override
  _NoConnectionScreenState createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  bool checking = false;

  void _checkConnection() async {
    setState(() {
      checking = true;
    });
    await context.read<AppState>().checkConnection();
    // mounted checks if widget is even displayed anymore
    if (mounted) {
      setState(() {
        checking = false;
      });
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
                activated: !checking,
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
