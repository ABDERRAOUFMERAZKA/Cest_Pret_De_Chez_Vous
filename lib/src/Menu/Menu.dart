import 'package:flutter/material.dart';

import '../../styles.dart';

class Menu extends StatelessWidget {
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
                    Text('Menu Screen', textAlign: TextAlign.start, style: Styles.headerLarge),
                  ],
                )
              ]
          )
      ),
    );
  }
}