import 'package:cest_pret_de_chez_vous/src/display_ads/utils/filter_ads.dart';
import 'package:flutter/widgets.dart';

import './display_ads_view_model.dart';
import '../model/ad.dart';
import '../service/retrieve_ads.dart';

class CurrentUserAdsViewModel extends DisplayAdsViewModel with ChangeNotifier {
  final String userId;

  List<Ad> _currentUserAds = [];

  List<Ad> get currentUserAds => _currentUserAds;

  CurrentUserAdsViewModel(this.userId) {
    _fetchAds();
  }

  @override
  Future<void> refreshAds() async {
    List<Ad> fetchedCurrentUserAds =
        await _fetchAds(fromServer: isItTimeToRefresh());
    this._currentUserAds = fetchedCurrentUserAds;
    lastAdRefresh = DateTime.now();
    notifyListeners();
  }

  @override
  Future<void> filterAds({String category, List<String> keywords}) async {
    List<Ad> fetchedCurrentUserAds = await _fetchAds(fromServer: false);
    List<Ad> filteredAds = FilterAd.filterAds(fetchedCurrentUserAds,
        category: category, keywords: keywords);
    this._currentUserAds = filteredAds;
  }

  Future<List<Ad>> _fetchAds({bool fromServer = false}) async {
    List<Map<String, dynamic>> jsonCurrentUserAds =
        await getAdsFromUser(this.userId, fromServer: fromServer);
    List<Ad> fetchedCurrentUserAds = [];
    for (var jsonAd in jsonCurrentUserAds) {
      fetchedCurrentUserAds.add(Ad.fromJson(jsonAd));
    }
    return fetchedCurrentUserAds;
  }
}
