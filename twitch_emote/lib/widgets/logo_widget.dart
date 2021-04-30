import 'package:flutter/cupertino.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Hero(
        tag: "logo",
        child: Container(
          margin: new EdgeInsets.only(bottom: 30),
          child: Image.network(
            'https://data.zgast.at/EmoteGuesser/Transparent_Icon.png',
            width: 200,
            height: 200,
          ),
        ),
      );
}
