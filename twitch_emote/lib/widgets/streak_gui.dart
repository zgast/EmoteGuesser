import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/Backend/randomPic.dart';
import 'package:twitch_emote/GUI/guess_widgets.dart';
import 'package:twitch_emote/helper/guesser_counter.dart';

import 'file:///C:/Users/Markus/Documents/GitHub/EmoteGuesser/twitch_emote/lib/widgets/homescreen.dart';

import '../helper/check.dart';
import 'no_connection.dart';

class StreakGUI extends StatefulWidget {
  @override
  StreakGUIState createState() => StreakGUIState();
}

class StreakGUIState extends State<StreakGUI>
    with SingleTickerProviderStateMixin {
  var _counter = new guessed_counter();
  TextEditingController _textEditingController = new TextEditingController();
  AnimationController _controller;
  int lastcount = 99;
  var counter;

  void _start() async {
    if (!(await check().checkConnection())) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => no_connection_GUI()));
    }
  }

  void incrementedCounter() async {
    _counter(true, false);
    await randomPic().get();
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => StreakGUI(),
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    counter = _counter(false, false).toString().padLeft(2, '0');
    _start();

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
              controller: _controller,
              counter: counter,
              length: 6,
            )),
            guess_textfield(
              incrementedCounter: incrementedCounter,
              textEditingController: _textEditingController,
            ),
            Container(
              child: Image.network(
                randomPic.URL,
                width: 300,
                height: 300,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    final int seconds = 6;
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: seconds));
    _controller.forward();
    _onCountDownFinish(seconds: seconds);
  }

  void _onCountDownFinish({int seconds}) async {
    await Future.delayed(Duration(seconds: seconds - 1));
    _controller.dispose();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => MyHomePage()));
  }
}
