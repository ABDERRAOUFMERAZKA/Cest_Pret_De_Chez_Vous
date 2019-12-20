/// Checks if a List contains contains at least one of the elements of
/// the validator list.
bool listContainsAtLeastOneOf(
    List<dynamic> listToCheck, List<dynamic> validatorList) {
  return listToCheck.fold(
      false, (acc, cur) => acc || validatorList.contains(cur));
}

/// Checks if a list is not null and contains the given element.
bool isListNotNullAndContains(List<dynamic> list, dynamic element) {
  if (list == null) return false;
  return (list.contains(element));
}

/// Please first check if you can't use List?.function() instead of this.
/// Checks if String or List is not null nor empty. Returns true if the variable
/// is neither a String nor a List but is not null.
bool isNotNullNorEmpty(dynamic element) {
  if (element == null)
    return false;
  else if (element is List || element is String) return element.isNotEmpty;
  return true;
}

/// Checks if String or List is null or empty. Returns false if the variable is
/// neither a String nor a List but is not null.
bool isNullOrEmpty(dynamic element) {
  if (element == null)
    return true;
  else if (element is List || element is String) return element.isEmpty;
  return false;
}
