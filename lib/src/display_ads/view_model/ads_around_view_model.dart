import 'package:cest_pret_de_chez_vous/src/category.dart';
import 'package:cest_pret_de_chez_vous/src/display_ads/utils/filter_ads.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

import './display_ads_view_model.dart';
import '../model/ad.dart';
import '../service/retrieve_ads.dart';

class AdsAroundViewModel extends DisplayAdsViewModel with ChangeNotifier {
  static const double _RADIUS = 10;

  List<Ad> _adsAround = [];
  Category category;
  List<String> keywords;

  List<Ad> get homeAds => _adsAround;

  AdsAroundViewModel(String userId) : super(userId) {
    _fetchAds(fromServer: true).then((receivedAds) {
      this._adsAround = receivedAds;
      notifyListeners();
    });
  }

  @override
  Future<void> refreshAds() async {
    List<Ad> allAdsAround = await _fetchAds(fromServer: isItTimeToRefresh());
    this._adsAround = allAdsAround;
    lastAdRefresh = DateTime.now();
    notifyListeners();
  }

  @override
  Future<void> filterAds({Category category, List<String> keywords}) async {
    this.category = category;
    this.keywords = keywords;

    List<Ad> allAdsAround = await _fetchAds(fromServer: false);
    List<Ad> filteredAds = FilterAd.filterAds(allAdsAround,
        category: category, keywords: keywords);

    this._adsAround = filteredAds;
    notifyListeners();
  }

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
