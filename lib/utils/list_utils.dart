bool listContainsAtLeastOneOf(
    List<dynamic> listToCheck, List<dynamic> validatorList) {
  return listToCheck.fold(
      false, (acc, cur) => acc || validatorList.contains(cur));
}

bool isListNotNullAndContains(List<dynamic> list, dynamic element) {
  if (list == null) return false;
  return (list.contains(element));
}

/** 
 * checks if variable is null or empty
 * for String and List
 */
bool isNotNullNorEmpty(dynamic element) {
  if (element == null)
    return false;
  else if (element is List || element is String) return element.isNotEmpty;
  return null;
}

bool isNullOrEmpty(dynamic element) {
  if (element == null)
    return true;
  else if (element is List || element is String) return element.isEmpty;
  return null;
}
