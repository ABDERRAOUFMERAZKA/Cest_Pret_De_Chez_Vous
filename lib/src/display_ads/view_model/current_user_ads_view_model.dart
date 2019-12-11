part of 'display_ads_view_model.dart';

class CurrentUserAdsViewModel extends DisplayAdsViewModel {
  CurrentUserAdsViewModel(String userId) : super(userId) {
    _fetchAds(fromServer: true).then((receivedAds) {
      this._adsToDisplay = receivedAds;
      notifyListeners();
    });
  }

  @override
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
