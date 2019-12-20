import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/login_view_model.dart';

class ValidationMail extends StatelessWidget {
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);
    String email = viewModel.currentUser.email;

    Widget loginButton(String text, Function onPressed) => Material(
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
                            'Please Check E-mail of Validation in this address $email',
                            textAlign: TextAlign.start,
                            style: Styles.textDefault),
                        SizedBox(
                          height: 25.0,
                        ),
                        loginButton(
                            "Send Email", viewModel.sendNewVerificationEmail),
                        SizedBox(
                          height: 25.0,
                        ),
                        loginButton("Logout", viewModel.signOut),
                      ],
                    )
                  ]))),
    );
  }
}
