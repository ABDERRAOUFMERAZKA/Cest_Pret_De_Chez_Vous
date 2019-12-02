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
  if (element is List || element is String)
    return element != null && element.isNotEmpty;
  return null;
}

bool isNullOrEmpty(dynamic element) {
  if (element is List || element is String)
    return element == null || element.isEmpty;
  return null;
}
