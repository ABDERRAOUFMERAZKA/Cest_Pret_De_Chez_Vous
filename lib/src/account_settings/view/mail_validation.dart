import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../styles.dart';

class ValidationMail extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<ValidationMail> {
  String _email;

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  getEmail() async {
    var currentUser = await FirebaseAuth.instance.currentUser();
    var currentUserMail = currentUser.email;
    setState(() {
      _email = currentUserMail;
    });
  }

  Widget build(BuildContext context) {
    loginButton(String text, onPressed) => Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.deepOrange,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 10.0, 15.0),
            onPressed: onPressed,
            child: Text(text,
                textAlign: TextAlign.center,
                style: Styles.mediumText.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        );

    validateMail() async {
      var currentUser = await FirebaseAuth.instance.currentUser();
      currentUser.sendEmailVerification();
    }

    logOut() {
      FirebaseAuth.instance.signOut();
    }

    return Scaffold(
      body: Container(
          child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            'Please Check E-mail of Validation in this adress $_email',
                            textAlign: TextAlign.start,
                            style: Styles.textDefault),
                        SizedBox(
                          height: 25.0,
                        ),
                        loginButton("Send Email", () => validateMail()),
                        SizedBox(
                          height: 25.0,
                        ),
                        loginButton("Logout", () => logOut()),
                      ],
                    )
                  ]))),
    );
  }
}
