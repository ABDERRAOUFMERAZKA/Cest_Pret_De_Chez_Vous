import 'package:flutter/material.dart';

import '../../styles.dart';

class Home extends StatelessWidget {
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
                Text('Home Screen',
                    textAlign: TextAlign.start, style: Styles.headerLarge),
              ],
            )
          ])),
    );
  }
}
