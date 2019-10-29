import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../../LoginValue.dart';
import '../../../styles.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:oauth1/oauth1.dart' as oauth1;


class Login extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<Login>{
  //State Variables
  bool isVerifier = false;
  String verifier;
  var apiResponse;

  static final apiKey = 'qZ8WnBdJDDuZua3v94FHWJeku';
  static final apiSecret = 'sDJpmmo6zxx4eDvfQYeFnJchW32K0V1OKO0QlUC2ZUsQWVKr93';
  var platform = new oauth1.Platform(
      'https://api.twitter.com/oauth/request_token', // temporary credentials request
      'https://api.twitter.com/oauth/authorize',     // resource owner authorization
      'https://api.twitter.com/oauth/access_token',  // token credentials request
      oauth1.SignatureMethods.hmacSha1              // signature method
  );

  var clientCredentials = new oauth1.ClientCredentials(apiKey, apiSecret);

  void _confirm() async {
    var auth = new oauth1.Authorization(clientCredentials, platform);
    try {
      var tokens =
      await auth.requestTokenCredentials(apiResponse.credentials, verifier);
      var client = new oauth1.Client(platform.signatureMethod, clientCredentials, tokens.credentials);
      if (verifier != '') {
        await client.get('https://api.twitter.com/1.1/statuses/home_timeline.json?count=1').then((res) {
          Provider.of<LoginValue>(context, listen : false).updateIsLogged(true);
        });
      }

      // NOTE: you can get optional values from AuthorizationResponse object
      print("Your screen name is " + apiResponse.optionalParameters['screen_name']);
    } on StateError {
       print('error state');
    }
  }

  void _login() async {
    var auth = new oauth1.Authorization(clientCredentials, platform);
    // request temporary credentials (request tokens)
    auth.requestTemporaryCredentials('oob').then((res) {
      // redirect to authorization page
       var newUrl =  auth.getResourceOwnerAuthorizationURI(res.credentials.token);
       launch(newUrl);

      // get verifier (PIN)
       setState(() { isVerifier = true; });
       setState(() { apiResponse = res; });


      // request token credentials (access tokens)
    }).then((res) {
      print('hello');
    });
}

  void _onChangeVer(String verif) {
    setState(() => verifier = verif);
  }


  Widget build(BuildContext context) {
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.deepOrange,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: isVerifier ? _confirm : _login,
        child: Text( isVerifier ? "Confirm" : "login",
            textAlign: TextAlign.center,
            style: Styles.mediumText.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final virifierField = TextField(
      obscureText: false,
      onChanged: _onChangeVer,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Verifier",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Twitter Account"),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 125.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                if(isVerifier) virifierField,
                SizedBox(
                  height: 15.0,
                ),
                loginButon,
                SizedBox(
                  height: 15.0,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}