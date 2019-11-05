import 'package:cest_pret_de_chez_vous/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../login_value.dart';
import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  //State Variables
  bool isVerified = false;
  String verifier;
  var apiResponse;

  final verifierController = TextEditingController();

  @override
  void initState() {
    super.initState();

    verifierController.addListener(_onVerifierChanged);
  }

  void _onVerifierChanged() {
    setState(() {
      verifier = verifierController.text;
    });
  }

  @override
  void dispose() {
    verifierController.dispose();
    super.dispose();
  }

  void _login() async {
    var auth = new TwitterApiAuthorization();
    // request temporary credentials (request tokens)
    var credentials =
        (await auth.requestTemporaryCredentials('oob')).credentials;

    // redirect to authorization page
    // TO DO deep link from distant site
    var newUrl = auth.getResourceOwnerAuthorizationURI(credentials.token);
    launch(newUrl);

    // change state to display input text for verifier
    setState(() {
      isVerified = true;
    });

    setState(() {
      apiResponse = credentials;
    });
  }

  void _confirm() async {
    var auth = new TwitterApiAuthorization();
    print("verifier: $verifier");
    try {
      var tokens = (await auth.requestTokenCredentials(apiResponse, verifier))
          .credentials;

      var definitiveClient = new TwitterApiClient(tokens);

      Provider.of<LoginValue>(context, listen: false).updateIsLogged(true);
      Provider.of<LoginValue>(context, listen: false)
          .updateClient(definitiveClient);
    } on StateError {
      // TO DO handle errors
      print('error state');
      Provider.of<LoginValue>(context, listen: false).updateIsLogged(false);
    } catch (e) {
      print("unknown error");
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

    final verifierField = TextField(
      autofocus: true,
      controller: verifierController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Verifier",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      obscureText: false,
      onEditingComplete: _confirm,
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
                    "assets/twitter_icon.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                if (isVerified) verifierField,
                SizedBox(
                  height: 15.0,
                ),
                isVerified
                    ? loginButton("Confirm", _confirm)
                    : loginButton("Login", _login),
                SizedBox(
                  height: 15.0,
                ),
                if (isVerified)
                  loginButton(
                      "Back",
                      () =>
                          setState(() => {isVerified = false, verifier = ''})),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
