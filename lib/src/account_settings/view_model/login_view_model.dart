import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../services/manage_auth.dart';
import '../utils/firebase_responses.dart';

enum LoginStatus { initialState, isLoading, isLoaded, onError }
enum ServerResponse { ok, platformError, otherError }

class LoginViewModel with ChangeNotifier {
  FirebaseUser currentUser;
  LoginStatus loginStatus = LoginStatus.initialState;
  String loginErrorMessage;

  LoginViewModel() {
    print("view model current user: $currentUser");
  }

  void updateCurrentUser(FirebaseUser newUser) {
    this.currentUser = newUser;
  }

  Future<void> signIn(
      GlobalKey<FormState> formKey, String email, String password) async {
    this.loginStatus = LoginStatus.isLoading;
    notifyListeners();
    final formState = formKey.currentState;
    String serverResponse;
    if (formState.validate()) {
      formState.save();
      serverResponse = await firebaseSignIn(email, password);
    } else {
      this.loginStatus = LoginStatus.initialState;
    }
    if (serverResponse == "OK") {
      this.loginStatus = LoginStatus.isLoaded;
    } else {
      this.loginStatus = LoginStatus.onError;
      this.loginErrorMessage =
          getErrorMessageFromFirebaseErrorCode(serverResponse);
    }
    notifyListeners();
  }

  Future<void> signUp(GlobalKey<FormState> formKey, String email,
      String password, String username) async {
    this.loginStatus = LoginStatus.isLoading;
    notifyListeners();
    final formState = formKey.currentState;
    String serverResponse;
    if (formState.validate()) {
      formState.save();
      serverResponse = await firebaseSignUp(email, password, username);
    } else {
      this.loginStatus = LoginStatus.initialState;
    }
    if (serverResponse == "OK") {
      this.loginStatus = LoginStatus.isLoaded;
    } else {
      this.loginStatus = LoginStatus.onError;
      this.loginErrorMessage =
          getErrorMessageFromFirebaseErrorCode(serverResponse);
    }
    notifyListeners();
  }

  Future<void> sendNewVerificationEmail() async {
    await currentUser.sendEmailVerification();
  }

  logout() async {
    await firebaseSignOut();
  }
}
