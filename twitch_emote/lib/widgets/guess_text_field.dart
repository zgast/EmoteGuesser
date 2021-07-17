import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:twitch_emote/models/game_state.dart';

class GuessTextField extends StatelessWidget {
  final TextEditingController textEditingController;

  GuessTextField({@required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: new EdgeInsets.only(bottom: 50, top: 30),
      child: PlatformTextField(
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        controller: textEditingController,
        cupertino: (_, __) => CupertinoTextFieldData(
          placeholder: "Emote",
        ),
        material: (_, __) => MaterialTextFieldData(
          enableSuggestions: false,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: 'Emote',
            labelStyle:
                const TextStyle(color: Color.fromARGB(209, 209, 209, 209)),
          ),
        ),
        onChanged: (text) async {
          if (await context.read<GameState>().checkInput(text)) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}
