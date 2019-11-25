import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:flutter/material.dart';

import '../model/ad.dart';

class DetailAds extends StatelessWidget {
  final Ad ad;
  DetailAds(this.ad);

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Text('Detail', style: Styles.navBarTitle),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              ad.title,
              style: Theme.of(context).textTheme.headline,
            ),
            Text(
              ad.category ?? '',
              style: Theme.of(context).textTheme.subhead,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                ad.description ?? '',
                style: Theme.of(context).textTheme.body1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
