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
  String _email, _password, _username;
  bool isUserCreated = false;
  bool isRegistering = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    var viewModel = Provider.of<LoginViewModel>(context);
    pillButton(String text, onPressed) => MaterialButton(
          color: Colors.deepOrange,
          disabledColor: Colors.grey,
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed:
              viewModel.loginStatus != LoginStatus.isLoading ? onPressed : null,
          child: Text(text,
              textAlign: TextAlign.center,
              style: Styles.mediumText
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        );

    final emailField = TextFormField(
      enabled: viewModel.loginStatus != LoginStatus.isLoading,
      obscureText: false,
      onChanged: (input) => _email = input.trim(),
      validator: (input) {
        if (!emailValidator(input)) {
          return 'Please enter a valid email';
        } else {
          return null;
        }
      },
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

    final usernameField = TextFormField(
      enabled: viewModel.loginStatus != LoginStatus.isLoading,
      obscureText: false,
      onChanged: (input) => _username = input,
      validator: (input) {
        if (!commonCharactersValidator(input)) {
          return 'Please enter a valid username.';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          icon: new Icon(
            Icons.person,
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextFormField(
      enabled: viewModel.loginStatus != LoginStatus.isLoading,
      obscureText: true,
      onChanged: (input) => _password = input,
      validator: (input) {
        if (input.length < 6) {
          return 'Please enter a valid password';
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 125.0,
                width: 125.0,
                child: viewModel.loginStatus != LoginStatus.isLoading
                    ? Icon(Icons.person, color: Colors.deepOrange, size: 150)
                    : CircularProgressIndicator(
                        backgroundColor: Colors.deepOrange,
                      ),
              ),
              SizedBox(
                height: 50.0,
                child: viewModel.loginStatus == LoginStatus.onError
                    ? Text(
                        viewModel.loginErrorMessage,
                        textAlign: TextAlign.center,
                        style: Styles.mediumErrorText,
                      )
                    : null,
              ),
              emailField,
              if (isRegistering) usernameField,
              SizedBox(
                height: 15.0,
                child: Text(
                  "Password must be 6 char long and contain a letter and a number.",
                  textAlign: TextAlign.start,
                  style: Styles.smallText,
                ),
              ),
              passwordField,
              if (!isRegistering)
                pillButton("Login",
                    () => viewModel.signIn(_formKey, _email, _password))
              else
                pillButton(
                    "Register",
                    () => viewModel.signUp(
                        _formKey, _email, _password, _username)),
              Text('Or', style: Styles.textDefault),
              FlatButton(
                onPressed: () {
                  setState(() {
                    isRegistering = !isRegistering;
                  });
                },
                child: Text(isRegistering ? "Login" : "Register"),
              ),
              if (isUserCreated)
                Text("Please confirm your account, confirmation mail was sent"),
            ]
                .map(
                  (c) => !(c is SizedBox)
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(36, 10, 36, 10),
                          child: c,
                        )
                      : c,
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
