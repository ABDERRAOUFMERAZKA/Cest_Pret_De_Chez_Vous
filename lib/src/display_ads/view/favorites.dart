import 'package:cest_pret_de_chez_vous/utils/list_utils.dart';
import 'package:cest_pret_de_chez_vous/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widget/ad_in_list.dart';
import './widget/no_ads_found.dart';
import '../model/ad.dart';
import '../view_model/display_ads_view_model.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<DisplayAdsViewModel>(context);
    List<Ad> currentUserFavoriteAds = viewModel.currentUserFavoriteAds;
    return isNotNullNorEmpty(currentUserFavoriteAds)
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              itemCount: currentUserFavoriteAds.length,
              itemBuilder: (context, index) {
                Ad currentAd = currentUserFavoriteAds[index];
                return AdInList(
                  currentAd,
                  uid: Provider.of<MainViewModel>(context).uid,
                  addAdToFavorites: () =>
                      viewModel.addAdToFavorites(currentAd.idStr),
                  removeFromFavorites: () =>
                      viewModel.removeAdFromFavorites(currentAd.idStr),
                );
              },
            ),
          )
        : Container(
            child: NoAdsFound(),
          );
  }
}
