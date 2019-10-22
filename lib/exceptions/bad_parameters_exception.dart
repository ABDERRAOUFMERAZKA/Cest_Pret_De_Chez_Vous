class BadParameterException implements Exception {
  final String errorMessage;
  BadParameterException([this.errorMessage]);

  String errMsg() =>
      errorMessage ?? 'The request doesn\'t have the requested parameters';
}
