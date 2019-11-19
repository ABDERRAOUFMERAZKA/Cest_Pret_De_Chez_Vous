import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

import '../model/ad.dart';
import '../service/retrieve_ads.dart';

class DisplayAdsPresenter with ChangeNotifier {
  final double _RADIUS = 10;
  List<Ad> _homeAds;
  List<Ad> _searchedAds;
  List<Ad> _currentUserAds;
  List<Ad> _searchedUserAds;

  List<Ad> get homeAds => _homeAds;
  List<Ad> get searchedAds => _searchedAds;
  List<Ad> get currentUserAds => _currentUserAds;
  List<Ad> get searchedUserAds => _searchedUserAds;

  DisplayAdsPresenter()
      : _homeAds = null,
        _searchedAds = null,
        _currentUserAds = null,
        _searchedUserAds = null;

  Future<GeoPoint> _getPositionAsFirebaseGeoPoint() async {
    Position currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return GeoPoint(currentPosition.latitude, currentPosition.longitude);
  }

  void fetchCurrentUserAds() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    List<Map<String, dynamic>> jsonAdsFromUser =
        await getAdsFromUser(currentUser.uid);
    List<Ad> adsFromUser = [];
    for (var jsonAd in jsonAdsFromUser) {
      adsFromUser.add(Ad.fromJson(jsonAd));
    }
    this._currentUserAds = adsFromUser;
  }

  fetchSearchedUserAds(String uid) async {
    List<Map<String, dynamic>> jsonAdsFromUser = await getAdsFromUser(uid);
    List<Ad> adsFromUser = [];
    for (var jsonAd in jsonAdsFromUser) {
      adsFromUser.add(Ad.fromJson(jsonAd));
    }
    this._searchedUserAds = adsFromUser;
  }

  void fetchHomeAds() async {
    GeoPoint firebaseGeoPoint = await _getPositionAsFirebaseGeoPoint();
    List<Map<String, dynamic>> jsonAllAdsAround =
        await getAdsAround(firebaseGeoPoint, _RADIUS);
    List<Ad> allAdsAround = [];
    for (var jsonAd in jsonAllAdsAround) {
      allAdsAround.add(Ad.fromJson(jsonAd));
    }
    this._homeAds = allAdsAround;
  }

  void searchAds([String category, List<String> keywords]) async {
    GeoPoint firebaseGeoPoint = await _getPositionAsFirebaseGeoPoint();
    List<Map<String, dynamic>> jsonAdsAround =
        await (String category, List<String> keywords) async {
      if ((category == null || category == "") &&
          (keywords == null || keywords.isEmpty)) {
        return await getAdsAround(firebaseGeoPoint, _RADIUS);
      } else if ((keywords == null || keywords.isEmpty)) {
        return await getAdsAroundWithCategory(
            firebaseGeoPoint, _RADIUS, category);
      } else if (category == null) {
        return await getAdsAroundWithKeywords(
            firebaseGeoPoint, _RADIUS, keywords);
      } else {
        return await getAdsAroundWithCategoryAndKeywords(
            firebaseGeoPoint, _RADIUS, category, keywords);
      }
    }(category, keywords);
    List<Ad> adsAround = [];
    for (var jsonAd in jsonAdsAround) {
      adsAround.add(Ad.fromJson(jsonAd));
    }
    this._searchedAds = adsAround;
  }
}
