class BadParameterException implements Exception {
  String errMsg() => 'The request doesn\'t have the requested parameters';
}
