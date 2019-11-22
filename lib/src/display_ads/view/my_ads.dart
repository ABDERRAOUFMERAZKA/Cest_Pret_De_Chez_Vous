import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:flutter/material.dart';

class MyAds extends StatelessWidget {
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
