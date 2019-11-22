import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:flutter/material.dart';

import '../../model/ad.dart';
import '../../view_model/display_ads_view_model.dart';

class AdInList extends StatelessWidget {
  final Ad ad;
  final String uid;

  Function addAdToFavorites;
  Function removeFromFavorites;

  AdInList(this.ad,
      {@required this.uid,
      @required this.addAdToFavorites,
      @required this.removeFromFavorites});

  bool isNotNullAndContains(List<String> list, String element) {
    if (list == null) return false;
    return (list.contains(element));
  }

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
                if (isNotNullAndContains(ad.favored, uid))
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
