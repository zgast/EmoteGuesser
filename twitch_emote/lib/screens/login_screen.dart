import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_emote/models/app_state.dart';
import 'package:twitch_emote/widgets/menu_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _textEditingController = new TextEditingController();

  bool loading = true;

  @override
  void initState() {
    // Adding frame callback, because we can't use setState before first build has finished
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (await context.read<AppState>().checkConnection()) {
        setState(() {
          loading = false;
        });
      }
    });
    super.initState();
  }

  void _login(String text) async {
    setState(() {
      loading = true;
    });

    var success = await context.read<AppState>().register(text);
    if (!success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to log you in ):')));
      setState(() {
        loading = false;
      });
    }
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Never call a function you don't want to be executed at any time in the
    /// build method. If you want to execute something on the first Widget launch
    /// use `initState`
    // _start();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: new EdgeInsets.only(bottom: 30),
              child: Image.network(
                'https://data.zgast.at/EmoteGuesser/Transparent_Icon.png',
                width: 200,
                height: 200,
              ),
            ),
            Container(
              //margin: new EdgeInsets.only(top: 300),
              child: Text(
                'Enter Username:',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              width: 400,
              margin: new EdgeInsets.only(
                  bottom: 100, top: 30, left: 30, right: 30),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Username'),
              ),
            ),
            MenuButton(
              name: "CONTINUE",
              activated: !loading,
              onPressed: () {
                if (!loading) {
                  _login(_textEditingController.text);
                }
              },
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
