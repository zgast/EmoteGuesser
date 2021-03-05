import 'dart:io';

class check {
  final String name = "KEKW";

  bool isEqual(String text) {
    if (name.toLowerCase() == text.toLowerCase()) {
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
