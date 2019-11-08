import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './presenter/login.dart';
import './view/login.dart' as loginView;

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => LoginPresenter(),
      child: loginView.Login(),
    );
  }
}
