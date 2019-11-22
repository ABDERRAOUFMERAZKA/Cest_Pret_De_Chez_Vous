import 'package:cest_pret_de_chez_vous/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widget/ad_in_list.dart';
import '../model/ad.dart';
import '../view_model/display_ads_view_model.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<DisplayAdsViewModel>(context);
    List<Ad> currentUserFavoriteAds = viewModel.currentUserFavoriteAds;
    viewModel.fetchHomeAds();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        itemCount: currentUserFavoriteAds.length,
        itemBuilder: (context, index) => AdInList(
          currentUserFavoriteAds[index],
          uid: Provider.of<MainViewModel>(context).uid,
        ),
      ),
    );
  }
}
