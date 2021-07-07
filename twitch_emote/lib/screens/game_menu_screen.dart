import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_emote/models/game_state.dart';
import 'package:twitch_emote/models/game_type.dart';
import 'package:twitch_emote/widgets/logo_widget.dart';
import 'package:twitch_emote/widgets/menu_button.dart';

import 'game_screen.dart';

class GameMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LogoWidget(),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: MenuButton(
              name: "TIME GAME",
              onPressed: () {
                context.read<GameState>().type = GameType.TIME;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => GameScreen(type: GameType.TIME)));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: MenuButton(
              name: "STREAK GAME",
              onPressed: () {
                context.read<GameState>().type = GameType.STREAK;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => GameScreen(type: GameType.STREAK),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
