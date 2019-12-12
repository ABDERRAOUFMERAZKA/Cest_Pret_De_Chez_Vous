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
    List<Ad> currentUserAds =
        await getAdsFromUser(this.userId, fromServer: fromServer);
    return currentUserAds;
  }
}
