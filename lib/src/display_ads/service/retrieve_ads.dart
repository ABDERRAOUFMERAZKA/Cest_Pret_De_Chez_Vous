import 'dart:math';
import 'package:cest_pret_de_chez_vous/utils/list_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/geo_compute.dart';

Future<List<Map<String, dynamic>>> _fetchAllAdsAround(
    GeoPoint geoPoint, double radius) async {
  Map<String, GeoPoint> boundingBox =
      boundingBoxCoordinates(geoPoint.latitude, geoPoint.longitude, radius);
  var response = await Firestore()
      .collection("ads")
      .where("location", isGreaterThan: boundingBox["swCorner"])
      .where("location", isLessThan: boundingBox["neCorner"])
      .getDocuments();
  var documents = response.documents;
  List<Map<String, dynamic>> docsAsMaps = [];
  documents.forEach((document) {
    Map docAsMap = document.data;
    docAsMap["idStr"] = document.documentID;
    double distance = distanceInMetersBetween(docAsMap["location"], geoPoint);
    if (distance < 1000 * radius) docsAsMaps.add(docAsMap);
  });
  return docsAsMaps;
}

Future<List<Map<String, dynamic>>> getAdsAround(
    GeoPoint geoPoint, double radius) async {
  return await _fetchAllAdsAround(geoPoint, radius);
}

Future<List<Map<String, dynamic>>> getAdsAroundWithCategory(
    GeoPoint geoPoint, double radius, String category) async {
  List<Map<String, dynamic>> allAdsAround =
      await _fetchAllAdsAround(geoPoint, radius);
  List<Map<String, dynamic>> filteredAds =
      allAdsAround.where((ad) => ad["category"] == category);
  return filteredAds;
}

Future<List<Map<String, dynamic>>> getAdsAroundWithKeywords(
    GeoPoint geoPoint, double radius, List<String> keywords) async {
  List<Map<String, dynamic>> allAdsAround =
      await _fetchAllAdsAround(geoPoint, radius);
  List<Map<String, dynamic>> filteredAds = allAdsAround
      .where((Map<String, dynamic> ad) =>
          listContainsAtLeastOneOf(ad["keywords"], keywords))
      .toList();
  return filteredAds;
}

Future<List<Map<String, dynamic>>> getAdsAroundWithCategoryAndKeywords(
    GeoPoint geoPoint,
    double radius,
    String category,
    List<String> keywords) async {
  List<Map<String, dynamic>> allAdsAround =
      await _fetchAllAdsAround(geoPoint, radius);
  List<Map<String, dynamic>> filteredAds = allAdsAround
      .where((Map<String, dynamic> ad) =>
          listContainsAtLeastOneOf(ad["keywords"], keywords) &&
          ad["category"] == category)
      .toList();
  return filteredAds;
}

Future<List<Map<String, dynamic>>> getAdsFromUser(String userId) async {
  var response = await Firestore()
      .collection("ads")
      .where("authorId", isEqualTo: userId)
      .getDocuments();
  var documents = response.documents;
  List<Map<String, dynamic>> docsAsMaps = [];
  documents.forEach((document) {
    Map<String, dynamic> docAsMap = document.data;
    docAsMap["idStr"] = document.documentID;
    docsAsMaps.add(docAsMap);
  });
  return docsAsMaps;
}

Future populateTable() async {
  double minWest = -4.486;
  double maxEast = 7.7521;
  double minSouth = 42.6888;
  double maxNorth = 51.0344;
  final _random = new Random();
  for (var i = 0; i < 5000; i++) {
    String title = "Title $i";
    double latitude = minSouth + _random.nextDouble() * (maxNorth - minSouth);
    double longitude = minWest + _random.nextDouble() * (maxEast - minWest);
    Firestore()
        .collection("ads")
        .add({"title": title, "location": GeoPoint(latitude, longitude)});
  }
  print("done");
}

Future<List<String>> getCategoriesList() async {
  var response = await Firestore().collection('category').getDocuments();
  var documents = response.documents;
  List<String> categories = ['--'];
  documents[0]['types'].forEach((category) {
    categories.add(category);
  });
  return categories;
}
