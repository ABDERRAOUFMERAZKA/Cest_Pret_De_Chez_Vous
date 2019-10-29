import 'package:cest_pret_de_chez_vous/LoginValue.dart';
import 'package:flutter/material.dart';
import './Navigation/Navigation.dart';
import './src/Login/widget/Login.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<LoginValue>(context).isLogged ? Tabs() : Login();
  }
}
