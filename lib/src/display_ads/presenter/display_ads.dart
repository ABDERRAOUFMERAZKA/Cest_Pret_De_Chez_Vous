import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

import '../model/ad.dart';
import '../service/retrieve_ads.dart';

class DisplayAdsPresenter with ChangeNotifier {
  final List<Ad> _homeAds;
  final List<Ad> _searchedAds;
  final List<Ad> _currentUserAds;
  final List<Ad> _searchedUserAds;

  List<Ad> get homeAds => _homeAds;
  List<Ad> get searchedAds => _searchedAds;
  List<Ad> get currentUser => _currentUserAds;
  List<Ad> get searchedUserAds => _searchedUserAds;

  DisplayAdsPresenter()
      : _homeAds = null,
        _searchedAds = null,
        _currentUserAds = null,
        _searchedUserAds = null;

  void fetchHomeAds() async {
    Position currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    GeoPoint firebaseGeoPoint =
        new GeoPoint(currentPosition.latitude, currentPosition.longitude);
    fetchAds(firebaseGeoPoint, 5);
  }
}
