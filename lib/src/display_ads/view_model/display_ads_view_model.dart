import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

import '../model/ad.dart';
import '../service/retrieve_ads.dart';
import '../utils/filter_ads.dart';
import '../../category.dart';

part 'ads_around_view_model.dart';
part 'current_user_ads_view_model.dart';
part 'favorite_ads_view_model.dart';

/// When extending this class, you should pay attention to use the
/// isItTimeToRefresh function to prevent to many calls to your database.
/// Use an optional {fromServer = false} parameter in your functions for
/// checking.
abstract class DisplayAdsViewModel with ChangeNotifier {
  /// Refresh period in milliseconds.
  static const double _REFRESH_DEBOUNCE_TIME = 15000;

  final String userId;
  List<Ad> _adsToDisplay = [];
  Category category;
  List<String> keywords;
  DateTime _lastAdsRefresh = DateTime.now();

  DisplayAdsViewModel(this.userId);

  List<Ad> get adsToDisplay => _adsToDisplay;

  bool isItTimeToRefresh() {
    DateTime refreshTime = DateTime.now();
    return refreshTime.difference(this._lastAdsRefresh) >
        Duration(milliseconds: _REFRESH_DEBOUNCE_TIME.toInt());
  }

  set lastAdRefresh(DateTime dateTime) => _lastAdsRefresh = dateTime;

  Future<void> addAdToFavorites(String adId) async {
    String userId = this.userId;
    await postNewAdToFavorites(adId, userId);
    notifyListeners();
  }

  Future<void> removeAdFromFavorites(String adId) async {
    String userId = this.userId;
    await deleteAdFromFavorites(adId, userId);
    notifyListeners();
  }

  /// This method updates your ListOfAds with distant server only if it is time.
  Future<void> refreshAds() async {
    List<Ad> allAdsAround = await _fetchAds(fromServer: isItTimeToRefresh());
    this._adsToDisplay = allAdsAround;
    lastAdRefresh = DateTime.now();
    notifyListeners();
  }

  /// This method updates update your ListOfAds from local Storage and curates
  /// them according to your local parameters.
  Future<void> filterAds({Category category, List<String> keywords}) async {
    this.category = category;
    this.keywords = keywords;

    List<Ad> allAdsAround = await _fetchAds(fromServer: false);
    List<Ad> filteredAds = FilterAd.filterAds(allAdsAround,
        category: category, keywords: keywords);

    this._adsToDisplay = filteredAds;
    notifyListeners();
  }

  Future<List<Ad>> _fetchAds({bool fromServer = false});
}
