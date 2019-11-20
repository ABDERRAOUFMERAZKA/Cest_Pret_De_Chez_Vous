String getErrorMessageFromFirebaseErrorCode(String errorCode) {
  String errorMessage;
  switch (errorCode) {
    case "ERROR_INVALID_EMAIL":
      errorMessage = "This email has invalid format";
      break;
    case "ERROR_WRONG_PASSWORD":
    case "ERROR_USER_NOT_FOUND":
      errorMessage = "Unknown email or wrong password";
      break;
    case "ERROR_USER_DISABLED":
      errorMessage = "This user is disabled, please contact staff";
      break;
    case "ERROR_TOO_MANY_REQUESTS":
      errorMessage = "Please wait and try again";
      break;
    case "ERROR_OPERATION_NOT_ALLOWED":
      errorMessage = "You are not allowed to do that";
      break;
    case "ERROR_WEAK_PASSWORD":
      errorMessage = "Password not strong enough";
      break;
    case "ERROR_EMAIL_ALREADY_IN_USE":
      errorMessage = "This email is already used by another user";
      break;
    default:
      errorMessage = "An unknown error occurred";
  }
  return errorMessage;
}
