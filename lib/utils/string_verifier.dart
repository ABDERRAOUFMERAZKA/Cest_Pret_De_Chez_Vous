/// This function checks if a String satisfies the email standard
bool emailValidator(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return false;
  } else {
    return true;
  }
}

/// This function checks if a String has upper and lower case letters,
/// numbers, and "_", "-", " ", for a username for example
bool commonCharactersValidator(String value) {
  Pattern pattern = r'^[A-z0-9\_\- ]{3,30}$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return false;
  } else {
    return true;
  }
}
