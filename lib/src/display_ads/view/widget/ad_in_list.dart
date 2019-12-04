import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:cest_pret_de_chez_vous/utils/date_utils.dart';
import 'package:cest_pret_de_chez_vous/utils/enum_utils.dart';
import 'package:cest_pret_de_chez_vous/utils/list_utils.dart';
import 'package:flutter/material.dart';

import '../ad_details.dart';
import '../../model/ad.dart';

class AdInList extends StatelessWidget {
  final Ad ad;
  final String uid;

  final Function addAdToFavorites;
  final Function removeFromFavorites;

  AdInList(this.ad,
      {@required this.uid,
      @required this.addAdToFavorites,
      @required this.removeFromFavorites});

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
                    EnumToString.parseCamelCase(ad.category),
                    style: Styles.mediumText,
                  ),
                  Text(
                    DateToString.fullNumbersWithCharBetween(ad.createdAt, " "),
                    style: Styles.smallText,
                  )
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
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdDetails(ad)),
                  ),
                ),
                if (isListNotNullAndContains(ad.favored, uid))
                  FlatButton(
                    child: Text('Remove from favorites'),
                    onPressed: () => removeFromFavorites(),
                  )
                else
                  FlatButton(
                    child: Text('Add to favorites'),
                    onPressed: () => addAdToFavorites(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
