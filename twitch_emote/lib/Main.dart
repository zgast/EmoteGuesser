import 'package:flutter/material.dart';
import 'package:flutter/src/material/button_theme.dart';
import 'package:twitch_emote/widgets/HomescreenGUI.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      home: HomescreenGUI(title: 'Twitch Emote Guesser'),
    );
  }
}
