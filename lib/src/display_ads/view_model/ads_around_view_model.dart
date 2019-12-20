part of 'display_ads_view_model.dart';

class AdsAroundViewModel extends DisplayAdsViewModel {
  static const double _RADIUS = 2;

  AdsAroundViewModel(String userId) : super(userId) {
    _fetchAds(fromServer: true).then((receivedAds) {
      this._adsToDisplay = receivedAds;
      notifyListeners();
    });
  }

  @override
  Future<List<Ad>> _fetchAds({bool fromServer = false}) async {
    Map<String, double> mapPosition = await _getPositionAsMap();
    List<Ad> allAdsAround = await getAdsAround(mapPosition, _RADIUS);
    return allAdsAround;
  }

  Future<Map<String, double>> _getPositionAsMap() async {
    Position currentPosition = Position(latitude: 48.8409, longitude: 2.24137);
    return {
      "latitude": currentPosition.latitude,
      "longitude": currentPosition.longitude,
    };
  }
}
