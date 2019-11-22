import 'package:flutter/material.dart';

import '../model/ad.dart';

class DetailAds extends StatelessWidget {
  final Ad ad;
  DetailAds(this.ad);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: <Widget>[
          Text(
            ad.title,
            style: Theme.of(context).textTheme.headline,
          ),
          Text(
            ad.category,
            style: Theme.of(context).textTheme.subhead,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              ad.description ?? '',
              style: Theme.of(context).textTheme.body1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                ad.description ?? '',
                style: Theme.of(context).textTheme.subtitle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}