import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/GUI/guess_widgets.dart';

import 'file:///C:/Users/Markus/Documents/GitHub/EmoteGuesser/twitch_emote/lib/widgets/homescreen.dart';

import '../helper/check.dart';
import 'no_connection.dart';

class streak_gui extends StatefulWidget {
  @override
  _streak_gui_state createState() => _streak_gui_state();
}

class _streak_gui_state extends State<streak_gui>
    with SingleTickerProviderStateMixin {
  streak_count _counter = new streak_count();
  TextEditingController _textEditingController = new TextEditingController();
  AnimationController _controller;
  var counter;
  void _checkConnection() async {
    if (!(await check().checkConnection())) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => no_connection_GUI()));
    }
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

  void incrementedCounter() {
    _counter(true, false);
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => streak_gui(),
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    counter = _counter(false, false).toString().padLeft(2, '0');
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
              controller: _controller,
              counter: counter,
            )),
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

class streak_count implements Function {
  static var count = 0;

  call(bool plus, bool reset) {
    if (plus) {
      count++;
    } else if (reset) {
      count = 0;
    }
    return count;
  }
}
