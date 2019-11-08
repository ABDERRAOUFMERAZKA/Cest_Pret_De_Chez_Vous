import 'package:flutter/widgets.dart';
import '../services/manage_auth.dart';

class LoginViewModel {
  LoginViewModel();
}

class LoginPresenter extends ValueNotifier<LoginViewModel> {
  LoginPresenter() : super(LoginViewModel());

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
}
