import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import '../services/manage_auth.dart';

class LoginPresenter with ChangeNotifier {
  signIn(GlobalKey<FormState> formKey, String email, String password) {
    final formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();
      firebaseSignIn(email, password);
    }
  }

  signUp(GlobalKey<FormState> formKey, String email, String password) {
    final formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();
      firebaseSignUp(email, password);
    }
  }

  logout() {
    FirebaseAuth.instance.signOut();
  }
}
