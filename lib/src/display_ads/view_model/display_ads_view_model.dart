import 'package:cest_pret_de_chez_vous/utils/list_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

import '../model/ad.dart';
import '../service/retrieve_ads.dart';

class DisplayAdsViewModel with ChangeNotifier {
  static const double _RADIUS = 10;
  List<Ad> _adsAround = [];
  List<Ad> _searchedAds = [];
  List<Ad> _currentUserAds = [];
  List<Ad> _currentUserFavoriteAds = [];
  List<Ad> _searchedUserAds = [];
  List<String> _categories = [];

  List<Ad> get homeAds => _adsAround;
  List<Ad> get searchedAds => _searchedAds;
  List<Ad> get currentUserAds => _currentUserAds;
  List<Ad> get currentUserFavoriteAds => _currentUserFavoriteAds;
  List<Ad> get searchedUserAds => _searchedUserAds;
  List<String> get categories => _categories;

  DisplayAdsViewModel() {
    _fetchAdsAround();
    _fetchCurrentUserAds();
    _fetchCurrentUserFavoriteAds();
    _getCategories();
  }

  Future<GeoPoint> _getPositionAsFirebaseGeoPoint() async {
    Position currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return GeoPoint(currentPosition.latitude, currentPosition.longitude);
  }

  void _fetchCurrentUserAds() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    List<Map<String, dynamic>> jsonAdsFromUser =
        await getAdsFromUser(currentUser.uid);
    List<Ad> adsFromUser = [];
    for (var jsonAd in jsonAdsFromUser) {
      adsFromUser.add(Ad.fromJson(jsonAd));
    }
    this._currentUserAds = adsFromUser;
    notifyListeners();
  }

  _fetchCurrentUserFavoriteAds() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    List<Map<String, dynamic>> jsonFavoriteAdsFromUser =
        await getFavoriteAdsFromUser(currentUser.uid);
    List<Ad> favoriteAdsFromUser = [];
    for (var jsonAd in jsonFavoriteAdsFromUser) {
      favoriteAdsFromUser.add(Ad.fromJson(jsonAd));
    }
    this._currentUserFavoriteAds = favoriteAdsFromUser;
    notifyListeners();
  }

  fetchSearchedUserAds(String uid) async {
    List<Map<String, dynamic>> jsonAdsFromUser = await getAdsFromUser(uid);
    List<Ad> adsFromUser = [];
    for (var jsonAd in jsonAdsFromUser) {
      adsFromUser.add(Ad.fromJson(jsonAd));
    }
    this._searchedUserAds = adsFromUser;
    notifyListeners();
  }

  void _fetchAdsAround() async {
    GeoPoint firebaseGeoPoint = await _getPositionAsFirebaseGeoPoint();
    List<Map<String, dynamic>> jsonAllAdsAround =
        await getAdsAround(firebaseGeoPoint, _RADIUS);
    List<Ad> allAdsAround = [];
    for (var jsonAd in jsonAllAdsAround) {
      allAdsAround.add(Ad.fromJson(jsonAd));
    }
    this._adsAround = allAdsAround;
    notifyListeners();
  }

  void searchAds([String category, List<String> keywords]) async {
    GeoPoint firebaseGeoPoint = await _getPositionAsFirebaseGeoPoint();
    List<Ad> searchedAds =
        await (String category, List<String> keywords) async {
      if ((category == null || category == "") && (isNullOrEmpty(keywords))) {
        return await getAdsAround(firebaseGeoPoint, _RADIUS);
      } else if ((isNullOrEmpty(keywords))) {
        List<Ad> filteredAds =
            _adsAround.where((ad) => ad.category == category);
        return filteredAds;
      } else if (category == null) {
        List<Ad> filteredAds = _adsAround
            .where((Ad ad) => listContainsAtLeastOneOf(ad.keywords, keywords))
            .toList();
        return filteredAds;
      } else {
        List<Ad> filteredAds = _adsAround
            .where((Ad ad) =>
                listContainsAtLeastOneOf(ad.keywords, keywords) &&
                ad.category == category)
            .toList();
        return filteredAds;
      }
    }(category, keywords);
    this._searchedAds = searchedAds;
    notifyListeners();
  }

  void _getCategories() async {
    this._categories = await getCategoriesList();
    notifyListeners();
  }

  void addAdToFavorites(String adId) async {
    String userId = (await FirebaseAuth.instance.currentUser()).uid;
    await postNewAdToFavorites(adId, userId);
  }

  void removeAdFromFavorites(String adId) async {
    String userId = (await FirebaseAuth.instance.currentUser()).uid;
    await deleteAdFromFavorites(adId, userId);
  }
}
