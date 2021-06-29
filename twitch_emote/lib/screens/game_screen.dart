import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:twitch_emote/models/app_state.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return WillPopScope(
      onWillPop: () async {
        // Catch Pop Event, because calling resetGame in the dispose Method is unsafe
        context.read<GameState>().resetGame();
        return true;
      },
      child: Scaffold(
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
                        key:
                            ValueKey(context.watch<GameState>().currentPic.url),
                        width: 300,
                        height: 300,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    context.read<AppState>().checkConnection();
    context.read<GameState>().loading = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<GameState>().startGame(widget.type, onFinish: () {
        if (mounted) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      });
    });

    super.initState();
  }
}
