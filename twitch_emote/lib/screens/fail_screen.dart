import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_emote/models/app_state.dart';
import 'package:twitch_emote/models/game_state.dart';
import 'package:twitch_emote/screens/home_screen.dart';
import 'package:twitch_emote/widgets/menu_button.dart';

class FailScreen extends StatefulWidget {
  @override
  _FailScreenState createState() => _FailScreenState();
}

class _FailScreenState extends State<FailScreen> {
  bool checking = false;

  void _checkConnection() async {
    setState(() {
      checking = true;
    });
    await context.read<AppState>().checkConnection();
    // mounted checks if widget is even displayed anymore
    if (mounted) {
      setState(() {
        checking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 60, 10, 0),
              child: Text(
                "YOU FAILED",
                style: const TextStyle(
                    fontSize: 50,
                    color: Colors.red,
                    fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              height: 130,
              width: double.maxFinite,
              child: Card(
                elevation: 15,
                shadowColor: Colors.deepPurple,
                color: Colors.deepPurple,
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "Emotename:",
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "${context.watch<GameState>().currentPic.name}",
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.red,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            context.watch<GameState>().loading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(
                        bottom: (MediaQuery.of(context).size.height - 630)),
                    child: CachedNetworkImage(
                      imageUrl: context.watch<GameState>().currentPic.url,
                      key: ValueKey(context.watch<GameState>().currentPic.url),
                      width: 300,
                      height: 300,
                    ),
                  ),
            Container(
              alignment: Alignment.bottomCenter,
              child: MenuButton(
                name: "Continue",
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => HomeScreen()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
