import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_emote/models/app_state.dart';

class FailScreen extends StatefulWidget {
  @override
  _FailScreenState createState() => _FailScreenState();
}

class _FailScreenState extends State<FailScreen> {
  bool checking = false;

  void _checkConnection() async {
    setState(() {
      checking = true;
    });
    await context.read<AppState>().checkConnection();
    // mounted checks if widget is even displayed anymore
    if (mounted) {
      setState(() {
        checking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40, left: 10, right: 10),
              height: MediaQuery.of(context).size.height - 20,
              width: double.maxFinite,
              child: Card(
                elevation: 15,
                shadowColor: Colors.deepPurple,
                color: Colors.deepPurple,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Text(
                        "YOU FAILED",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Text(
                        "YOU FAILED",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
