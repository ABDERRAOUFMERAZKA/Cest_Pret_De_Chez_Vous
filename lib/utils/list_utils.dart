bool listContainsAtLeastOneOf(
    List<dynamic> listToCheck, List<dynamic> validatorList) {
  return listToCheck.fold(
      false, (acc, cur) => acc || validatorList.contains(cur));
}
