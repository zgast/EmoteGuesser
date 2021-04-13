import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/Backend/RandomPic.dart';
import 'package:twitch_emote/GUI/GuessWidgets.dart';
import 'package:twitch_emote/helper/GuesserCounter.dart';

import '../helper/Check.dart';
import 'HomescreenGUI.dart';
import 'NoConnectionGUI.dart';

class TimeGameGUI extends StatefulWidget {
  @override
  _TimeGameGUIState createState() => _TimeGameGUIState();
}

class _TimeGameGUIState extends State<TimeGameGUI>
    with SingleTickerProviderStateMixin {
  static String URL = randomPic.URL;
  String name = randomPic.name;
  TextEditingController _textEditingController = new TextEditingController();
  AnimationController _controller;
  var counter = new guesserCounter();
  var stringCounter;

  void _checkConnection() async {
    URL = randomPic.URL;
    if (!(await Check().checkConnection())) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => NoConnectionGUI()));
    }
  }

  void nextStep() async {
    await randomPic().get();
    setState(() {
      counter(true, false);
      stringCounter = guesserCounter.count.toString().padLeft(2, '0');
    });
    setState(() {
      URL = randomPic.URL;
    });
  }

  @override
  Widget build(BuildContext context) {
    stringCounter = guesserCounter.count.toString().padLeft(2, '0');
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
            GuessTextField(
                incrementedCounter: nextStep,
                textEditingController: _textEditingController),
            Container(
              child: CachedNetworkImage(
                imageUrl: URL,
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
        .pushReplacement(MaterialPageRoute(builder: (_) => HomescreenGUI()));
  }
}
