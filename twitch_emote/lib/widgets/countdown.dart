import 'package:flutter/material.dart';

class Countdown extends AnimatedWidget {
  final Animation<int> animation;

  Countdown({Key key, @required this.animation})
      : super(key: key, listenable: animation);

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    return Text(
      "$timerText",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    );
  }
}
