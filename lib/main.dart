import 'package:flutter/material.dart';

import './welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
