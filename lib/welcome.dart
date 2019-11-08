import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './Navigation/Navigation.dart';
import './src/login/login.dart';

class Welcome extends StatelessWidget {
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        return snapshot.data != null ? Tabs() : Login();
      },
    );
  }
}
