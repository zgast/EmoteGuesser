import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:twitch_emote/models/app_state.dart';
import 'package:twitch_emote/screens/game_menu_screen.dart';
import 'package:twitch_emote/screens/no_connection_screen.dart';
import 'package:twitch_emote/screens/settings_screen.dart';
import 'package:twitch_emote/screens/stats_screen.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;

  List<Widget> widgets = [
    GameMenuScreen(),
    StatsScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    var homeState = context.watch<AppState>().homeState;

    switch (homeState) {
      case HomeState.LOADING:
        {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      case HomeState.LOGIN:
        {
          return LoginScreen();
        }
      case HomeState.NO_CONNECTION:
        {
          return NoConnectionScreen();
        }
      case HomeState.HOME:
        {
          return PlatformScaffold(
            //resizeToAvoidBottomInset: false,
            body: widgets[_currentIndex],
            bottomNavBar: PlatformNavBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Platform.isIOS
                      ? Icon(CupertinoIcons.game_controller)
                      : Icon(Icons.sports_esports),
                  label: 'GAMES',
                ),
                BottomNavigationBarItem(
                  icon: Platform.isIOS
                      ? Icon(CupertinoIcons.person_crop_circle)
                      : Icon(Icons.account_circle_outlined),
                  label: 'ACCOUNT',
                ),
                BottomNavigationBarItem(
                  icon: Platform.isIOS
                      ? Icon(CupertinoIcons.gear)
                      : Icon(Icons.settings),
                  label: 'SETTINGS',
                ),
              ],
              currentIndex: _currentIndex,
              //selectedItemColor: Colors.deepPurple,
              itemChanged: (newindex) {
                setState(() {
                  _currentIndex = newindex;
                });
              },
            ),
          );
        }
    }
    return Container();
  }
}
