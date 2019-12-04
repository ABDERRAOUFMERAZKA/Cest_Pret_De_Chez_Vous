import 'dart:math';

/// Creates a random String of the given size. This String contains
/// only UPPERCASE and lowercase characters, and numbers.
/// Very useful for IDs
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

/// Creates a random Date from 1st day of startDate's month to last day
/// of endDate's month (included). Doesn't take leap years into account.
///
/// Please note that each year between your two dates has the same chance
/// to be picked.
/// For example: between 11/2017 and 02/2019
///   with many dates generated, months of november and december 2017,
///   and january and february 2019 will have more dates than other months.
DateTime randomDate(DateTime startDate, DateTime endDate) {
  var random = Random();
  int year = startDate.year + random.nextInt(endDate.year - startDate.year + 1);
  int month;
  if (year == startDate.year)
    month = startDate.month + random.nextInt(12 - startDate.month);
  else if (year == endDate.year)
    month = random.nextInt(endDate.month) + 1;
  else
    month = random.nextInt(12) + 1;
  int day;
  switch (month) {
    case 2:
      day = random.nextInt(28) + 1;
      break;
    case 1:
    case 3:
    case 5:
    case 7:
    case 8:
    case 10:
    case 12:
      day = random.nextInt(31) + 1;
      break;
    default:
      day = random.nextInt(30) + 1;
      break;
  }
  int hour = random.nextInt(24);
  int minute = random.nextInt(60);
  int second = random.nextInt(60);
  int millisecond = random.nextInt(1000);
  int microsecond = random.nextInt(1000);
  DateTime randomDate = DateTime(
      year, month, day, hour, minute, second, millisecond, microsecond);
  return randomDate;
}
