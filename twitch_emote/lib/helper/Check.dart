import 'dart:io';

class Check {
  static Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('api.zgast.at');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}
