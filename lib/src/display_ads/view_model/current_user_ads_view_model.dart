import './display_ads_view_model.dart';
import '../model/ad.dart';
import '../service/retrieve_ads.dart';
import '../utils/filter_ads.dart';
import '../../category.dart';

class CurrentUserAdsViewModel extends DisplayAdsViewModel {
  List<Ad> _currentUserAds = [];

  List<Ad> get currentUserAds => _currentUserAds;

  CurrentUserAdsViewModel(String userId) : super(userId) {
    _fetchAds(fromServer: true).then((receivedAds) {
      this._currentUserAds = receivedAds;
      notifyListeners();
    });
  }

  @override
  Future<void> refreshAds() async {
    List<Ad> fetchedCurrentUserAds =
        await _fetchAds(fromServer: isItTimeToRefresh());
    this._currentUserAds = fetchedCurrentUserAds;
    lastAdRefresh = DateTime.now();
    notifyListeners();
  }

  @override
  Future<void> filterAds({Category category, List<String> keywords}) async {
    List<Ad> fetchedCurrentUserAds = await _fetchAds(fromServer: false);
    List<Ad> filteredAds = FilterAd.filterAds(fetchedCurrentUserAds,
        category: category, keywords: keywords);
    this._currentUserAds = filteredAds;
  }

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
