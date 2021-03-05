import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;

  MenuButton({@required this.name, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        height: 50.0,
        width: 600,
        child: RaisedButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.deepPurple)),
          padding: EdgeInsets.all(10.0),
          color: Colors.deepPurple,
          textColor: Colors.white,
          child: Text(name, style: TextStyle(fontSize: 15)),
        ));
  }
}
