import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './src/account_settings/presenter/login.dart';
import './src/display_ads/presenter/display_ads.dart';
import './Welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (context) => LoginPresenter()),
          ChangeNotifierProvider(
            builder: (context) => DisplayAdsPresenter(),
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
