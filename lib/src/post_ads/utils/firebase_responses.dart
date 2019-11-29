String getErrorMessageFromFirebaseErrorCode(String errorCode) {
  String errorMessage;
  switch (errorCode) {
    default:
      errorMessage = "An unknown error occurred";
  }
  return errorMessage;
}
