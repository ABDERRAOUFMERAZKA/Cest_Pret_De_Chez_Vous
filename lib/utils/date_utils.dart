class DateToString {
  static String fullNumbersWithCharBetween(
      DateTime dateTime, String chatBetween) {
    String string =
        "${dateTime.day}$chatBetween${dateTime.month}$chatBetween${dateTime.year}";
    return string;
  }
}
