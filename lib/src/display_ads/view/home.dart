import 'package:cest_pret_de_chez_vous/src/display_ads/model/ad.dart';
import 'package:cest_pret_de_chez_vous/src/display_ads/view/widget/ad_in_list.dart';
import 'package:cest_pret_de_chez_vous/src/display_ads/view_model/display_ads_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../welcome.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<DisplayAdsViewModel>(context);
    List<Ad> homeAds = viewModel.homeAds;
    viewModel.fetchHomeAds();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        itemCount: homeAds.length,
        itemBuilder: (context, index) {
          Ad currentAd = homeAds[index];
          return AdInList(
            currentAd,
            uid: Provider.of<MainViewModel>(context).uid,
            addAdToFavorites: () => viewModel.addAdToFavorites(currentAd.idStr),
            removeFromFavorites: () =>
                viewModel.removeAdFromFavorites(currentAd.idStr),
          );
        },
      ),
    );
  }
}
