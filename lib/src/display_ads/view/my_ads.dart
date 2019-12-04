import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:cest_pret_de_chez_vous/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widget/filter_pop_up.dart';
import './widget/list_of_ads.dart';
import './widget/no_ads_found.dart';
import '../model/ad.dart';
import '../view_model/current_user_ads_view_model.dart';

class MyAds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<CurrentUserAdsViewModel>(context);
    List<Ad> currentUserAds = viewModel.currentUserAds;
    return Column(
      children: <Widget>[
        FlatButton(
          color: Colors.deepOrange,
          textColor: Colors.white,
          child: Text("Filter"),
          onPressed: () async {
            Map<String, dynamic> filterParams =
                await FilterPopUp.showFilterPopup(context);
            if (filterParams != null) {
              viewModel.filterAds(
                category: filterParams["category"],
                keywords: filterParams["keywords"],
              );
            }
          },
        ),
        Expanded(
          child: RefreshIndicator(
            backgroundColor: Styles.refreshIndicatorColor,
            child: isNotNullNorEmpty(currentUserAds)
                ? ListOfAds(
                    viewModel.currentUserAds,
                    uid: viewModel.userId,
                    addAdToFavorites: viewModel.addAdToFavorites,
                    removeAdFromFavorites: viewModel.removeAdFromFavorites,
                  )
                : SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: NoAdsFound(),
                    ),
                  ),
            onRefresh: viewModel.refreshAds,
          ),
        ),
      ],
    );
  }
}
