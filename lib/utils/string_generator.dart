import 'dart:math';

String randomString(int length) {
  var rand = new Random();
  var codeUnits = new List.generate(length, (index) {
    int letterCode = rand.nextInt(62) + 48;
    if (letterCode >= 58 && letterCode < 65) {
      letterCode += 7;
    }
    if (letterCode >= 91 && letterCode < 97) {
      letterCode += 6;
    }
    return letterCode;
  });

  return new String.fromCharCodes(codeUnits);
}
