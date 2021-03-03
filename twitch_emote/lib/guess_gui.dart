import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'file:///C:/Users/Markus/Documents/GitHub/EmoteGuesser/twitch_emote/lib/helper/check.dart';

import 'helper/stop_watch.dart';

class GuessGUI extends StatefulWidget {
  @override
  _GuessGUIState createState() => _GuessGUIState();
}

class _GuessGUIState extends State<GuessGUI>
    with SingleTickerProviderStateMixin {
  TextEditingController _textEditingController = new TextEditingController();
  AnimationController _controller;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _controller.forward();
  }

  void incrementedCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Twitch Emote Guesser"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: new EdgeInsets.only(top: 30, left: 50),
                      child: Text(
                        '$counter',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                    Container(
                      margin:
                          new EdgeInsets.only(top: 30, right: 50, left: 200),
                      alignment: Alignment.topLeft,
                      child: Countdown(
                        animation: StepTween(
                          begin: 10,
                          end: 0,
                        ).animate(_controller),
                      ),
                    ),
                  ]),
            ),
            Container(
              width: 300,
              margin: new EdgeInsets.only(bottom: 50, top: 50),
              child: TextField(
                controller: _textEditingController,
                onChanged: (text) {
                  if (check().isEqual(text)) {
                    _textEditingController.clear();
                    incrementedCounter();
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Emote'),
              ),
            ),
            Container(
              child: Image.network(
                'https://www.streamscheme.com/wp-content/uploads/2020/07/kekw-emote.jpg',
                width: 300,
                height: 300,
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
