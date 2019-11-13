import './src/account_settings/view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './Navigation/Navigation.dart';
import 'package:cest_pret_de_chez_vous/src/login/view/mail_validation.dart';

class Welcome extends StatelessWidget {
  getLoggedContent(data) {
    if (data == null) {
      return Login();
    } else if(data.isEmailVerified) {
      return Tabs();
    } return ValidationMail();
  }
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        return getLoggedContent(snapshot.data);
      },
    );
  }
}