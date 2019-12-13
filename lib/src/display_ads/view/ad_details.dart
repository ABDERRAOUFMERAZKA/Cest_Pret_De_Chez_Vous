import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:cest_pret_de_chez_vous/utils/enum_utils.dart';
import 'package:flutter/material.dart';

import '../model/ad.dart';

class AdDetails extends StatelessWidget {
  final Ad ad;
  AdDetails(this.ad);

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Text('Detail', style: Styles.navBarTitle),
    );

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          Text(
            ad.title,
            style: Theme.of(context).textTheme.headline,
          ),
          Text(
            EnumToString.parseCamelCase(ad.category),
            style: Theme.of(context).textTheme.subhead,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              ad.description ?? 'No description.',
              style: Theme.of(context).textTheme.body1,
            ),
          ),
          Expanded(
            child:
                // Image.network(
                //   'https://interactive-examples.mdn.mozilla.net/media/examples/grapefruit-slice-332-332.jpg',
                // ),
                GridView.count(
              crossAxisCount: 3,
              children: List.generate(ad.picturesUrl.length, (index) {
                return Container(
                  child: Image.network(ad.picturesUrl[index]),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
