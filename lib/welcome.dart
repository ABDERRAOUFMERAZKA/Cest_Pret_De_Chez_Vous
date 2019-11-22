import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './navigation/navigation.dart';
import './src/account_settings/view/login.dart';
import './src/account_settings/view/mail_validation.dart';
import './src/display_ads/view_model/display_ads_view_model.dart';

class MainViewModel with ChangeNotifier {
  String uid;
  MainViewModel(this.uid);
}

class Welcome extends StatelessWidget {
  getLoggedContent(data) {
    if (data == null) {
      return Login();
    } else if (data.isEmailVerified) {
      return ChangeNotifierProvider(
        builder: (context) => DisplayAdsViewModel(),
        child: Tabs(),
      );
    }
    return ValidationMail();
  }

  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        return ChangeNotifierProvider(
            builder: (context) => MainViewModel(snapshot.data?.uid),
            child: getLoggedContent(snapshot.data));
      },
    );
  }
}
