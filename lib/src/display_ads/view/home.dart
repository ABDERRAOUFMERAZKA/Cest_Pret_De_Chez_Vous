import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:cest_pret_de_chez_vous/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widget/list_of_ads.dart';
import './widget/no_ads_found.dart';
import '../model/ad.dart';
import '../view_model/display_ads_view_model.dart';
import '../../account_settings/view_model/login_view_model.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("context: ${context.toString()}");
    var viewModel = Provider.of<DisplayAdsViewModel>(context);
    List<Ad> homeAds = viewModel.homeAds;
    return RefreshIndicator(
      backgroundColor: Styles.refreshIndicatorColor,
      child: isNotNullNorEmpty(homeAds)
          ? ListOfAds(
              viewModel.homeAds,
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
      onRefresh: viewModel.refreshAdsAround,
    );
  }
}
