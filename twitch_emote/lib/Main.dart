import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_emote/models/app_state.dart';
import 'package:twitch_emote/models/game_state.dart';
import 'package:twitch_emote/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppState appState = AppState();

  @override
  build(BuildContext context) {
    return MaterialApp(
      title: 'Twitch Emote',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.deepPurple)),
          padding: EdgeInsets.all(10.0),
        ),
        buttonColor: Colors.deepPurple,
      ),
      home: ChangeNotifierProvider<AppState>(
        create: (_) => appState,
        child: ChangeNotifierProvider<GameState>(
          create: (_) => GameState(appState),
          child: HomeScreen(title: 'Twitch Emote Guesser'),
        ),
      ),
    );
  }
}
