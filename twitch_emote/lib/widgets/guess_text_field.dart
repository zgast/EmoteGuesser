import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_emote/models/game_state.dart';

class GuessTextField extends StatelessWidget {
  final TextEditingController textEditingController;

  GuessTextField({@required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: new EdgeInsets.only(bottom: 50, top: 50),
      child: TextField(
        controller: textEditingController,
        enableSuggestions: false,
        onChanged: (text) async {
          if (await context.read<GameState>().checkInput(text)) {
            textEditingController.clear();
          }
        },
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: 'Emote'),
      ),
    );
  }
}
