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
    List<Map<String, dynamic>> jsonFavoriteAds =
        await getFavoriteAdsFromUser(this.userId, fromServer: fromServer);
    List<Ad> favoriteAds = [];
    for (var jsonAd in jsonFavoriteAds) {
      favoriteAds.add(Ad.fromJson(jsonAd));
    }
    return favoriteAds;
  }
}
