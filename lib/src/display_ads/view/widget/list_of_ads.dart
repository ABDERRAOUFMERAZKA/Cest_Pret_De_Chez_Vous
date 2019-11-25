import 'package:flutter/cupertino.dart';

import './ad_in_list.dart';
import '../../model/ad.dart';

class ListOfAds extends StatelessWidget {
  final List<Ad> listOfAdsToDisplay;
  final String uid;
  final Function addAdToFavorites;
  final Function removeAdFromFavorites;

  ListOfAds(this.listOfAdsToDisplay,
      {@required this.uid,
      @required this.addAdToFavorites,
      @required this.removeAdFromFavorites});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: listOfAdsToDisplay.length,
        itemBuilder: (context, index) {
          Ad currentAd = listOfAdsToDisplay[index];
          return AdInList(
            currentAd,
            uid: uid,
            addAdToFavorites: () => addAdToFavorites(currentAd.idStr),
            removeFromFavorites: () => removeAdFromFavorites(currentAd.idStr),
          );
        },
      ),
    );
  }
}
