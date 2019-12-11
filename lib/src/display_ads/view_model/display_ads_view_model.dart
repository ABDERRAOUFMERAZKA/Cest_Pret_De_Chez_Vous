import 'package:flutter/widgets.dart';

import '../service/retrieve_ads.dart';

/// When extending this class, you should pay attention to use the
/// isItTimeToRefresh function to prevent to many calls to your database.
/// Use an optional {fromServer = false} parameter in your functions for
/// checking.
abstract class DisplayAdsViewModel with ChangeNotifier {
  /// Refresh period in milliseconds.
  static const double _REFRESH_DEBOUNCE_TIME = 15000;

  final String userId;

  DisplayAdsViewModel(this.userId);

  DateTime _lastAdsRefresh = DateTime.now();

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

  /// This method should update your ListOfAds with distant server only
  /// if it is time.
  /// Use isItTimeToRefresh() to check.
  /// At the end of your function, you should set lastAdRefresh = DateTime.now()
  Future<void> refreshAds();

  /// This method should update your ListOfAds from local Storage.
  Future<void> filterAds();
}
