import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:flutter/material.dart';

import '../../model/ad.dart';

class AdInList extends StatelessWidget {
  final Ad ad;
  final String uid;

  AdInList(this.ad, {@required String uid}) : uid = uid;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    ad.title,
                    style: Styles.headerLarge,
                  ),
                  Text(
                    ad.category,
                    style: Styles.mediumText,
                  ),
                ],
              ),
              Flexible(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Wrap(
                        children: <Widget>[
                          Text(
                            ad.description,
                            style: Styles.textDefault,
                          )
                        ],
                      )))
            ],
          ),
          ButtonTheme(
            // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('SEE DETAILS'),
                  onPressed: () {/* ... */},
                ),
                FlatButton(
                  child: Text((ad.favored.contains(uid))
                      ? 'Remove from favorites'
                      : "Add to favorites"),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
