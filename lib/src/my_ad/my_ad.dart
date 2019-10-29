import 'package:flutter/material.dart';

import '../../styles.dart';

class MyAd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('My Ad Screen',
                    textAlign: TextAlign.start, style: Styles.headerLarge),
              ],
            )
          ])),
    );
  }
}
