import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './navigation/navigation.dart';
import './src/account_settings/view/login.dart';
import './src/account_settings/view/mail_validation.dart';

class Welcome extends StatelessWidget {
  getLoggedContent(data) {
    if (data == null) {
      return Login();
    } else if (data.isEmailVerified) {
      return Tabs();
    }
    return ValidationMail();
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
