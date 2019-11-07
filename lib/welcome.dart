import 'package:cest_pret_de_chez_vous/login_value.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './Navigation/Navigation.dart';
import './src/login/login.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<LoginValue>(context).isLogged ? Tabs() : Login();
  }
}
