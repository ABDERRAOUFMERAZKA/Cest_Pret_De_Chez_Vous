import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:cest_pret_de_chez_vous/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widget/list_of_ads.dart';
import './widget/no_ads_found.dart';
import '../model/ad.dart';
import '../view_model/favorite_ads_view_model.dart';
import '../../account_settings/view_model/login_view_model.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<FavoriteAdsViewModel>(context);
    List<Ad> currentUserFavoriteAds = viewModel.favoriteAds;
    return RefreshIndicator(
      backgroundColor: Styles.refreshIndicatorColor,
      child: isNotNullNorEmpty(currentUserFavoriteAds)
          ? ListOfAds(
              currentUserFavoriteAds,
              uid: Provider.of<LoginViewModel>(context).currentUserId,
              addAdToFavorites: viewModel.addAdToFavorites,
              removeAdFromFavorites: viewModel.removeAdFromFavorites,
            )
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                margin: EdgeInsets.all(10),
                child: NoAdsFound(),
              ),
            ),
      onRefresh: viewModel.refreshAds,
    );
  }
}
