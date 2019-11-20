import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:cest_pret_de_chez_vous/utils/string_verifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/login_view_model.dart';

class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  //State Variables
  String _email, _password;
  bool isUserCreated = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    var presenter = Provider.of<LoginPresenter>(context);
    loginButton(String text, onPressed) => Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.deepOrange,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: onPressed,
            child: Text(text,
                textAlign: TextAlign.center,
                style: Styles.mediumText.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        );

    final emailField = TextFormField(
      obscureText: false,
      onSaved: (input) => _email = input.trim(),
      validator: emailValidator,
      decoration: InputDecoration(
          icon: new Icon(
            Icons.mail,
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextFormField(
      obscureText: true,
      onSaved: (input) => _password = input,
      validator: (input) {
        if (input.length < 6) {
          return 'Please, Provide a password with 6 characters minimum';
        } else
          return null;
      },
      decoration: InputDecoration(
          icon: new Icon(
            Icons.lock,
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Login Or Register"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                  height: 125.0,
                  child:
                      Icon(Icons.person, color: Colors.deepOrange, size: 150),
                ),
                SizedBox(
                  height: 25.0,
                ),
                emailField,
                SizedBox(
                  height: 15.0,
                ),
                passwordField,
                SizedBox(
                  height: 25.0,
                ),
                loginButton("Login",
                    () => presenter.signIn(_formKey, _email, _password)),
                SizedBox(
                  height: 15.0,
                ),
                Text('Or', style: Styles.textDefault),
                SizedBox(
                  height: 5.0,
                ),
                loginButton("Register",
                    () => presenter.signUp(_formKey, _email, _password)),
                if (isUserCreated)
                  Text(
                      "please confirm your account, confirmation mail was sent"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
