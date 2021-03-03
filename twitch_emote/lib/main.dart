import 'package:flutter/material.dart';
import 'package:flutter/src/material/button_theme.dart';
import 'package:twitch_emote/homescreen.dart';

import 'file:///C:/Users/Markus/Documents/GitHub/EmoteGuesser/twitch_emote/lib/helper/check.dart';

void main() async {
  var bool = await check().checkConnection();
  if (bool) {
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  build(BuildContext context) {
    return MaterialApp(
      title: 'Twitch Emote',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        backgroundColor: Colors.white,
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.deepPurple)),
          padding: EdgeInsets.all(10.0),
        ),
        buttonColor: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Twitch Emote Guesser'),
    );
  }
}
