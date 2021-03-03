import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class no_connection_GUI extends StatefulWidget {
  @override
  _no_connection_GUIState createState() => _no_connection_GUIState();
}

class _no_connection_GUIState extends State<no_connection_GUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                'Sry, no network connection!',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
