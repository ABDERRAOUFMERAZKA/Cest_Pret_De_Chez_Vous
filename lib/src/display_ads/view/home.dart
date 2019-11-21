import 'package:cest_pret_de_chez_vous/src/display_ads/model/ad.dart';
import 'package:cest_pret_de_chez_vous/src/display_ads/view/widget/ad_in_list.dart';
import 'package:cest_pret_de_chez_vous/src/display_ads/view_model/display_ads_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  List<Ad> dummyAds = [
    Ad(
        "title",
        "idStr",
        "category",
        "authorId",
        [],
        ["keyWord"],
        "this is my description and it is verrrryyyyy looooong ok stop now this is awkward",
        null)
  ];

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<DisplayAdsViewModel>(context);
    List<Ad> homeAds = viewModel.homeAds;
    viewModel.fetchHomeAds();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
          itemCount: homeAds.length,
          itemBuilder: (context, index) =>
              AdInList(homeAds[index], isFavorable: true)),
    );
  }
}
