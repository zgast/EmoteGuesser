import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/homescreen.dart';

import 'helper/check.dart';
import 'helper/stop_watch.dart';
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
    final int seconds = 5;
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
    _controller.dispose();
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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: new EdgeInsets.only(top: 30, left: 50),
                      child: Text(
                        counter,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                    Container(
                      margin:
                          new EdgeInsets.only(top: 30, right: 50, left: 190),
                      alignment: Alignment.topLeft,
                      child: Countdown(
                        animation: StepTween(
                          begin: 5,
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
