/// This code is from this repo: https://github.com/rknell/flutterEnumsToString
/// We decided to copy it because the functions didn't satisfy us, so we changed
/// them.

import 'string_utils.dart';

class EnumToString {
  static String parse(enumItem) {
    if (enumItem == null) return null;
    return enumItem.toString().split('.')[1];
  }

  static String parseCamelCase(enumItem) {
    if (enumItem == null) return null;
    final parsed = EnumToString.parse(enumItem);
    return camelCaseToWords(parsed);
  }

  static T fromString<T>(List<T> enumValues, String value) {
    if (value == null || enumValues == null) return null;
    return enumValues.singleWhere(
        (enumItem) =>
            EnumToString.parse(enumItem)?.toLowerCase() == value?.toLowerCase(),
        orElse: () => null);
  }
}
