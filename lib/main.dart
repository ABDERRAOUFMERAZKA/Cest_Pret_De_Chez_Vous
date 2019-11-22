import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './src/account_settings/view_model/login_view_model.dart';
import './welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => LoginViewModel(),
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
      ),
    );
  }
}
