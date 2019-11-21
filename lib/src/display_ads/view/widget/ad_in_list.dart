import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:flutter/material.dart';

import '../../model/ad.dart';

class AdInList extends StatelessWidget {
  final Ad ad;
  final bool isFavorable;

  AdInList(this.ad, {@required isFavorable}) : isFavorable = isFavorable;

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
                  child: Text('VOIR DETAILS'),
                  onPressed: () {/* ... */},
                ),
                FlatButton(
                  child: Text('Ajouter Au favoris'),
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
