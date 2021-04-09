import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/Backend/randomPic.dart';
import 'package:twitch_emote/GUI/guess_widgets.dart';
import 'package:twitch_emote/helper/guesser_counter.dart';

import '../helper/check.dart';
import 'homescreen.dart';
import 'no_connection.dart';

class GuessGUI extends StatefulWidget {
  @override
  _GuessGUIState createState() => _GuessGUIState();
}

class _GuessGUIState extends State<GuessGUI>
    with SingleTickerProviderStateMixin {
  static String URL = randomPic.URL;
  TextEditingController _textEditingController = new TextEditingController();
  AnimationController _controller;
  var counter = new guessed_counter();
  var stringCounter;

  void _checkConnection() async {
    if (!(await check().checkConnection())) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => no_connection_GUI()));
    }
  }

  void nextStep() async {
    await randomPic().get();
    setState(() {
      counter(true, false);
      stringCounter = guessed_counter.count.toString().padLeft(2, '0');
    });
    setState(() {
      URL = randomPic.URL;
    });
  }

  @override
  Widget build(BuildContext context) {
    stringCounter = guessed_counter.count.toString().padLeft(2, '0');
    _checkConnection();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Twitch Emote Guesser"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: counter_timer(
                counter: stringCounter,
                controller: _controller,
                length: 20,
              ),
            ),
            guess_textfield(
                incrementedCounter: nextStep,
                textEditingController: _textEditingController),
            Container(
              child: Image.network(
                URL,
                key: ValueKey(URL),
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

  @override
  void initState() {
    final int seconds = 20;
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: seconds));
    _controller.forward();
    _onCountDownFinish(seconds: seconds);
  }

  void _onCountDownFinish({int seconds}) async {
    await Future.delayed(Duration(seconds: seconds - 1));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => MyHomePage()));
  }
}
