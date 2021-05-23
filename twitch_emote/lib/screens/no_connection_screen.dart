import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:twitch_emote/models/app_state.dart';
import 'package:twitch_emote/widgets/menu_button.dart';

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
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 450, top: 300),
              child: Text(
                'Sry, no network connection!',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
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
