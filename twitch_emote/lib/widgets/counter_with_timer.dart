import 'package:flutter/material.dart';
import 'package:twitch_emote/models/game_state.dart';

import 'package:provider/provider.dart';

class CounterWithTimer extends StatelessWidget {
  const CounterWithTimer();

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
            context.watch<GameState>().streakLength.toString().padLeft(2, '0'),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        Container(
            margin: new EdgeInsets.only(top: 30, right: 50, left: 190),
            alignment: Alignment.topLeft,
            child: Text(
              "${context.watch<GameState>().remainingSeconds}s",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            )),
      ],
    );
  }
}
