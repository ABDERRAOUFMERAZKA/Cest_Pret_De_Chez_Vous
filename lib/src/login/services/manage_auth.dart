import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

Future<void> firebaseSignIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } catch (e) {
    if (e is PlatformException) {
      return e.message;
    }
    return e.message;
  }
}

Future<void> firebaseSignUp(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    var currentUser = await FirebaseAuth.instance.currentUser();
    currentUser.sendEmailVerification();
  } catch (e) {
    if (e is PlatformException) {
      return e.message;
    }
    print(e.runtimeType);
    return (e.message);
  }
}

