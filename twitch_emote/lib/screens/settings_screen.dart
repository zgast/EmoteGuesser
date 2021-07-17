import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitch_emote/models/app_state.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  var value = false;
  var user;

  _initScreen(BuildContext context) async {
    context.read<AppState>().checkConnection();
    user = context.read<AppState>().loggedInUser;
  }

  _openGithub(String URL) async {
    if (await canLaunch(URL)) {
      await launch(URL);
    } else {
      throw 'Could not launch $URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    _initScreen(context);
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Settings'),
        cupertino: (_, __) => CupertinoNavigationBarData(
          // Issue with cupertino where a bar with no transparency
          // will push the list down. Adding some alpha value fixes it (in a hacky way)
          backgroundColor: Colors.deepPurple,
        ),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'Account',
            tiles: [
              SettingsTile(
                title: 'Username',
                subtitle: user.name,
                leading: Icon(context.platformIcons.accountCircle),
                trailing: SizedBox(),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'ID',
                subtitle: user.id,
                leading: Icon(context.platformIcons.info),
                trailing: SizedBox(),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Log out',
                subtitle: 'press to logout',
                trailing: SizedBox(),
                leading: Icon(context.platformIcons.delete),
                onPressed: (BuildContext context) async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.clear();
                  exit(0);
                },
              )
            ],
          ),
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'Information',
            tiles: [
              SettingsTile(
                title: 'App Version',
                subtitle: '1.0',
                leading: Icon(Icons.analytics),
                trailing: SizedBox(),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'API Version',
                subtitle: '1.0',
                trailing: SizedBox(),
                leading: Icon(Icons.api),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                trailing: SizedBox(),
                leading: Icon(context.platformIcons.book),
              ),
              SettingsTile(
                title: 'App Code',
                subtitle: 'Click me',
                leading: Icon(Icons.code),
                onPressed: (BuildContext context) {
                  _openGithub("https://github.com/zgast/EmoteGuesser");
                },
              ),
              SettingsTile(
                title: 'Backend Code',
                subtitle: 'Click me',
                leading: Icon(Icons.code),
                onPressed: (BuildContext context) {
                  _openGithub("https://github.com/zgast/EmoteGuesserBackend");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
