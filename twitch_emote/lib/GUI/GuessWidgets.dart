import 'package:flutter/material.dart';
import 'package:twitch_emote/helper/Check.dart';
import 'package:twitch_emote/helper/Countdown.dart';

class counter_timer extends StatelessWidget {
  final String counter;
  final AnimationController controller;
  final int length;

  counter_timer(
      {@required this.counter,
      @required this.controller,
      @required this.length});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: new EdgeInsets.only(top: 30, left: 50),
            child: Text(
              counter,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          Container(
            margin: new EdgeInsets.only(top: 30, right: 50, left: 190),
            alignment: Alignment.topLeft,
            child: Countdown(
              animation: StepTween(
                begin: length,
                end: 0,
              ).animate(controller),
            ),
          ),
        ]);
  }
}

class GuessTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final VoidCallback incrementedCounter;

  GuessTextField(
      {@required this.incrementedCounter,
      @required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: new EdgeInsets.only(bottom: 50, top: 50),
      child: TextField(
        controller: textEditingController,
        onChanged: (text) {
          if (Check().isEqual(text)) {
            textEditingController.clear();
            incrementedCounter();
          }
        },
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: 'Emote'),
      ),
    );
  }
}
