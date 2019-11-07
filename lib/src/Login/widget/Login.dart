import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../login_value.dart';
import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }


  Widget build(BuildContext context) {
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
        if(input.length < 6){
          return 'Please, Provide a password with 6 characters minimum';
        }
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
                  child: Icon(Icons.person, color: Colors.deepOrange, size: 150),
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
                loginButton("Login", signIn),
                SizedBox(
                  height: 15.0,
                ),
                Text('Or', style: Styles.textDefault),
                SizedBox(
                  height: 5.0,
                ),
                loginButton("Register", Register),
                if (isUserCreated) Text("please confirm your account, confirmation mail was sent"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if(formState.validate()) {
      formState.save();
      try {
        var user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
          if(user.user.isEmailVerified) {
            Provider.of<LoginValue>(context, listen: false).updateIsLogged(true);
          }
      } catch(e) {
          print(e.message);
      }

    }
  }

  Future<void> Register() async {
    final formState = _formKey.currentState;
    if(formState.validate()) {
      formState.save();
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        var CurrentUser = await FirebaseAuth.instance.currentUser();
        CurrentUser.sendEmailVerification();
        setState(() {
          isUserCreated = true;
        });
      } catch(e) {
        print(e.message);
      }

    }
  }
}
