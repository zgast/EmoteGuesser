import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/GUI/guess_widgets.dart';

import '../helper/check.dart';
import 'homescreen.dart';
import 'no_connection.dart';

class GuessGUI extends StatefulWidget {
  @override
  _GuessGUIState createState() => _GuessGUIState();
}

class _GuessGUIState extends State<GuessGUI>
    with SingleTickerProviderStateMixin {
  TextEditingController _textEditingController = new TextEditingController();
  AnimationController _controller;
  int counter = 0;
  var stringCounter;
  void _checkConnection() async {
    if (!(await check().checkConnection())) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => no_connection_GUI()));
    }
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
    // save this shit
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => MyHomePage()));
  }

  void incrementedCounter() {
    setState(() {
      counter++;
      stringCounter = counter.toString().padLeft(2, '0');
    });
  }

  @override
  Widget build(BuildContext context) {
    stringCounter = counter.toString().padLeft(2, '0');
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
                incrementedCounter: incrementedCounter,
                textEditingController: _textEditingController),
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
