import './display_ads_view_model.dart';
import '../utils/filter_ads.dart';
import '../model/ad.dart';
import '../service/retrieve_ads.dart';
import '../../category.dart';

class FavoriteAdsViewModel extends DisplayAdsViewModel {
  List<Ad> _favoriteAds = [];

  List<Ad> get favoriteAds => _favoriteAds;

  FavoriteAdsViewModel(String userId) : super(userId) {
    _fetchAds(fromServer: true).then((receivedAds) {
      this._favoriteAds = receivedAds;
      notifyListeners();
    });
  }

  @override
  Future<void> refreshAds() async {
    List<Ad> favoriteAds = await _fetchAds(fromServer: isItTimeToRefresh());
    this._favoriteAds = favoriteAds;
    lastAdRefresh = DateTime.now();
    notifyListeners();
  }

  @override
  Future<void> filterAds({Category category, List<String> keywords}) async {
    List<Ad> favoriteAds = await _fetchAds(fromServer: false);
    List<Ad> filteredAds =
        FilterAd.filterAds(favoriteAds, category: category, keywords: keywords);
    this._favoriteAds = filteredAds;
  }

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
