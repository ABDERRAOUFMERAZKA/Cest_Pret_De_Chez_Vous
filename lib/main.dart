import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './src/account_settings/presenter/login.dart';
import './utils/store_provider.dart';
import './Welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StoreProvider<LoginViewModel, LoginPresenter>(
            builder: (_) => LoginPresenter(),
          ),
        ],
        child: MaterialApp(
          home: Welcome(),
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.white,
            textTheme: TextTheme(
              title: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent),
            ),
          ),
        ));
  }
}
