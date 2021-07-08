import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_emote/models/game_state.dart';

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
          padding: new EdgeInsets.only(top: 40, left: 50),
          child: Text(
            context.watch<GameState>().streakLength.toString().padLeft(2, '0'),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
        ),
        Container(
            margin: new EdgeInsets.only(top: 30, right: 39, left: 190),
            alignment: Alignment.topLeft,
            child: Text(
              "${context.watch<GameState>().remainingSeconds}s".padLeft(3, '0'),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white),
            )),
      ],
    );
  }
}
