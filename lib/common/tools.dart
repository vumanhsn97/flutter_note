import 'dart:math';

class Tools {
  static String randomString({length = 10}) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    var rnd = Random(DateTime.now().microsecondsSinceEpoch);
    var result = '';
    for (var i = 0; i < length; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }
}