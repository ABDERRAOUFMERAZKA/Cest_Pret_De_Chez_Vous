import 'package:cest_pret_de_chez_vous/src/display_ads/utils/filter_ads.dart';
import 'package:flutter/widgets.dart';

import './display_ads_view_model.dart';
import '../model/ad.dart';
import '../service/retrieve_ads.dart';

class FavoriteAdsViewModel extends DisplayAdsViewModel with ChangeNotifier {
  final String userId;

  List<Ad> _favoriteAds = [];

  List<Ad> get favoriteAds => _favoriteAds;

  FavoriteAdsViewModel(this.userId) {
    _fetchAds(fromServer: true);
  }

  @override
  Future<void> refreshAds() async {
    List<Ad> favoriteAds = await _fetchAds(fromServer: isItTimeToRefresh());
    this._favoriteAds = favoriteAds;
    lastAdRefresh = DateTime.now();
    notifyListeners();
  }

  @override
  Future<void> filterAds({String category, List<String> keywords}) async {
    List<Ad> favoriteAds = await _fetchAds(fromServer: false);
    List<Ad> filteredAds =
        FilterAd.filterAds(favoriteAds, category: category, keywords: keywords);
    this._favoriteAds = filteredAds;
  }

  Future<List<Ad>> _fetchAds({bool fromServer = false}) async {
    List<Map<String, dynamic>> jsonFavoriteAds =
        await getFavoriteAdsFromUser(this.userId, fromServer: fromServer);
    List<Ad> favoriteAds = [];
    for (var jsonAd in jsonFavoriteAds) {
      favoriteAds.add(Ad.fromJson(jsonAd));
    }
    return favoriteAds;
  }
}
