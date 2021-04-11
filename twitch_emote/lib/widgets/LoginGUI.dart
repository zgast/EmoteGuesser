import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/GUI/Buttons.dart';
import 'package:twitch_emote/backend/Login.dart';
import 'package:twitch_emote/widgets/NoConnectionGUI.dart';

import '../helper/Check.dart';
import 'HomescreenGUI.dart';

class LoginGUI extends StatefulWidget {
  LoginGUI({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginGUIState createState() => _LoginGUIState();
}

class _LoginGUIState extends State<LoginGUI> {
  TextEditingController _textEditingController = new TextEditingController();
  void _start() async {
    if (!(await Check().checkConnection())) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => NoConnectionGUI()));
    }
  }

  void _login(String text) async {
    Login().newUser(text);
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
              //margin: new EdgeInsets.only(top: 300),
              child: Text(
                'Enter Username:',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              width: 400,
              margin: new EdgeInsets.only(
                  bottom: 100, top: 30, left: 30, right: 30),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Username'),
              ),
            ),
            MenuButton(
              name: "CONTINUE",
              onPressed: () {
                _login(_textEditingController.text);
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
