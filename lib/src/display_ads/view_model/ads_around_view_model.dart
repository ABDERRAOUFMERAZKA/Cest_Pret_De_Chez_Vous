part of 'display_ads_view_model.dart';

class AdsAroundViewModel extends DisplayAdsViewModel {
  static const double _RADIUS = 10;

  AdsAroundViewModel(String userId) : super(userId) {
    _fetchAds(fromServer: true).then((receivedAds) {
      this._adsToDisplay = receivedAds;
      notifyListeners();
    });
  }

  @override
  Future<List<Ad>> _fetchAds({bool fromServer = false}) async {
    Map<String, double> mapPosition = await _getPositionAsMap();
    List<Map<String, dynamic>> jsonAllAdsAround =
        await getAdsAround(mapPosition, _RADIUS);
    List<Ad> allAdsAround = [];
    for (var jsonAd in jsonAllAdsAround) {
      allAdsAround.add(Ad.fromJson(jsonAd));
    }
    return allAdsAround;
  }

  Future<Map<String, double>> _getPositionAsMap() async {
    Position currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return {
      "latitude": currentPosition.latitude,
      "longitude": currentPosition.longitude,
    };
  }
}
