bool listContainsAtLeastOneOf(
    List<dynamic> listToCheck, List<dynamic> validatorList) {
  return listToCheck.fold(
      false, (acc, cur) => acc || validatorList.contains(cur));
}

bool isNotNullAndContains(List<dynamic> list, dynamic element) {
  if (list == null) return false;
  return (list.contains(element));
}

bool isNotNullNorEmpty(List<dynamic> list) {
  return list != null && list.isNotEmpty;
}
