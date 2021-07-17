import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_emote/models/app_state.dart';
import 'package:twitch_emote/widgets/menu_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _textEditingControllerUN = new TextEditingController();
  TextEditingController _textEditingControllerPW = new TextEditingController();
  var method = "PRESS TO LOGIN";
  var username = "Username";
  var message = "PLEASE REGISTER";
  bool loading = true;
  bool register = true;

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

  void _login(String username, String password) async {
    setState(() {
      loading = true;
    });
    var success = true;
    if (register) {
      success = await context.read<AppState>().register(username, password);
    } else {
      success = await context.read<AppState>().login(username, password);
    }
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
                '$message',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              width: 400,
              margin:
                  new EdgeInsets.only(bottom: 10, top: 30, left: 30, right: 30),
              child: TextField(
                controller: _textEditingControllerUN,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: '$username'),
              ),
            ),
            Container(
              width: 400,
              margin: new EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 600,
                  top: 0,
                  left: 30,
                  right: 30),
              child: TextField(
                controller: _textEditingControllerPW,
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password'),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 50.0,
                width: 600,
                child: RaisedButton(
                  onPressed: () {
                    if (!loading) {
                      setState(() {
                        register = !register;
                        if (method == "PRESS TO LOGIN") {
                          method = "PRESS TO REGISTER";
                          username = "Username#ID";
                          message = "PLEASE LOGIN";
                        } else {
                          method = "PRESS TO LOGIN";
                          username = "Username";
                          message = "PLEASE REGISTER";
                        }
                      });
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.deepPurple)),
                  padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  textColor: Colors.deepPurple,
                  child: Text("$method", style: TextStyle(fontSize: 15)),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 5),
                alignment: Alignment.bottomCenter,
                child: MenuButton(
                  name: "CONTINUE",
                  activated: !loading,
                  onPressed: () {
                    if (!loading) {
                      _login(_textEditingControllerUN.text,
                          _textEditingControllerPW.text);
                    }
                  },
                )),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
