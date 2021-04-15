import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/models/app_state.dart';

import 'package:provider/provider.dart';
import 'package:twitch_emote/models/game_state.dart';
import 'package:twitch_emote/models/game_type.dart';
import 'package:twitch_emote/widgets/counter_with_timer.dart';
import 'package:twitch_emote/widgets/guess_text_field.dart';

class GameScreen extends StatefulWidget {
  final GameType type;

  const GameScreen({Key key, @required this.type}) : super(key: key);
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Twitch Emote Guesser"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: CounterWithTimer(),
            ),
            GuessTextField(textEditingController: _textEditingController),
            context.watch<GameState>().loading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    child: CachedNetworkImage(
                      imageUrl: context.watch<GameState>().currentPic.url,
                      key: ValueKey(context.watch<GameState>().currentPic.url),
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
    context.read<AppState>().checkConnection();
    context.read<GameState>().startGame(widget.type, onFinish: () {
      Navigator.popUntil(context, (route) => route.isFirst);
    });
    super.initState();
  }
}
