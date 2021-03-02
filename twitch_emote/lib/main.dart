import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:twitch_emote/homescreen.dart';
import 'package:twitch_emote/no_connection.dart';
import 'package:twitch_emote/check.dart';

void main() async {
  var bool = await check().checkConnection();
  if(bool){
    runApp(MyApp());
  }else{
    runApp(no_connection());
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
      ),

        home: MyHomePage(title: 'Twitch Emote Guesser'),
    );
  }
}
