part of 'display_ads_view_model.dart';

class FavoriteAdsViewModel extends DisplayAdsViewModel {
  FavoriteAdsViewModel(String userId) : super(userId) {
    _fetchAds(fromServer: true).then((receivedAds) {
      this._adsToDisplay = receivedAds;
      notifyListeners();
    });
  }

  @override
  Future<List<Ad>> _fetchAds({bool fromServer = false}) async {
    List<Ad> favoriteAds =
        await getFavoriteAdsFromUser(this.userId, fromServer: fromServer);
    return favoriteAds;
  }
}
