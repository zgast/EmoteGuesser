import 'dart:io';

import 'package:twitch_emote/Backend/randomPic.dart';

class check {
  bool isEqual(String text) {
    if (randomPic.name.toLowerCase() == text.toLowerCase()) {
      return true;
    }
    return false;
  }

  Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('api.zgast.at');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return Future<bool>.value(true);
      }
    } on SocketException catch (_) {
      return Future<bool>.value(false);
    }
  }
}
