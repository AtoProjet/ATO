import 'dart:math';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String randomAlphanumeric(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


getChatRoomIdById(String a, String b) {
  print("Creating getChatRoomIdById");
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
