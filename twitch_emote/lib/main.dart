import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:twitch_emote/models/app_state.dart';
import 'package:twitch_emote/models/game_state.dart';
import 'package:twitch_emote/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppState appState = AppState();

  @override
  build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => appState,
      child: ChangeNotifierProvider<GameState>(
        create: (_) => GameState(appState),
        child: PlatformApp(
          title: 'Twitch Emote',
          home: HomeScreen(title: 'Twitch Emote Guesser'),
          material: (_, __) => MaterialAppData(
            themeMode: ThemeMode.light,
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
          ),
          cupertino: (_, __) => CupertinoAppData(
            theme: CupertinoThemeData(
              barBackgroundColor: Colors.white,
              scaffoldBackgroundColor: Colors.white,
              primaryColor: Colors.deepPurple,
            ),
          ),
        ),
      ),
    );
  }
}
