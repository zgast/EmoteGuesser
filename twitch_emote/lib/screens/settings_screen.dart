import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
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
                leading: Icon(Icons.account_circle),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'ID',
                subtitle: user.id,
                leading: Icon(Icons.info),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Token/Password',
                subtitle: 'click me to copy token',
                leading: Icon(Icons.vpn_key),
                onPressed: (BuildContext context) {
                  Clipboard.setData(ClipboardData(text: user.token));
                },
              ),
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
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'API Version',
                subtitle: '1.0',
                leading: Icon(Icons.api),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {},
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
