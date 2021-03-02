import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/guess_gui.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset : false,
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
              margin: EdgeInsets.all(20),
              height: 50.0,
                width: 600,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.deepPurple)),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (_)=> GuessGUI()));
                  },
                  padding: EdgeInsets.all(10.0),
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                  child: Text("TIME GAME",
                  style: TextStyle(fontSize: 15)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 50.0,
              width: 600,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.deepPurple)),
                onPressed: () {},
                padding: EdgeInsets.all(10.0),
                color: Colors.deepPurple,
                textColor: Colors.white,
                child: Text("STREAK GAME",
                    style: TextStyle(fontSize: 15)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 50.0,
              width: 600,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.deepPurple)),
                onPressed: () {},
                padding: EdgeInsets.all(10.0),
                color: Colors.deepPurple,
                textColor: Colors.white,
                child: Text("STATS",
                    style: TextStyle(fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}