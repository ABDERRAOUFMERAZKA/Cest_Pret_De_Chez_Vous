import 'dart:math';
import 'package:cest_pret_de_chez_vous/utils/list_utils.dart';
import 'package:cest_pret_de_chez_vous/utils/random_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/geo_compute.dart';

Future<List<Map<String, dynamic>>> _fetchAds(
    Query query, bool fromServer) async {
  var response = await query
      .orderBy("createdAt")
      .getDocuments(source: fromServer ? Source.serverAndCache : Source.cache);
  var documents = response.documents;
  List<Map<String, dynamic>> docsAsMaps = [];
  documents.forEach((document) {
    Map docAsMap = document.data;
    docAsMap["category"] = docAsMap["category"].toUpperCase();
    docsAsMaps.add(docAsMap);
  });

  if (isNotNullNorEmpty(docsAsMaps))
    docsAsMaps.sort((var ad1, var ad2) {
      if (ad1["createdAt"] != null && ad2["createdAt"] != null)
        return -ad1["createdAt"].compareTo(ad2["createdAt"]);
      return 1;
    });
  return docsAsMaps;
}

Future<List<Map<String, dynamic>>> getAdsAround(
    Map<String, double> position, double radius,
    {bool fromServer = false}) async {
  Map<String, Map<String, double>> boundingBox = boundingBoxCoordinates(
      position["latitude"], position["longitude"], radius);

  Map<String, GeoPoint> geoBoundingBox = {
    "swCorner": GeoPoint(boundingBox["swCorner"]["latitude"],
        boundingBox["swCorner"]["longitude"]),
    "neCorner": GeoPoint(boundingBox["neCorner"]["latitude"],
        boundingBox["neCorner"]["longitude"]),
  };

  Query ref = Firestore()
      .collection("ads")
      .orderBy("location")
      .where("location", isGreaterThan: geoBoundingBox["swCorner"])
      .where("location", isLessThan: geoBoundingBox["neCorner"]);

  //Firebase doesn't currently curate with geo position, so we have to filter again.
  List<Map<String, dynamic>> adsAround =
      (await _fetchAds(ref, fromServer)).where((ad) {
    Map<String, double> adLocationAsMap = {
      "latitude": ad["location"].latitude,
      "longitude": ad["location"].longitude
    };
    double distance = distanceInMetersBetween(adLocationAsMap, position);
    return (distance < 1000 * radius);
  }).toList();

  return adsAround;
}

Future<List<Map<String, dynamic>>> getAdsFromUser(String userId,
    {fromServer = false}) async {
  Query query =
      Firestore().collection("ads").where("authorId", isEqualTo: userId);

  List<Map<String, dynamic>> docsAsMaps = await _fetchAds(query, fromServer);

  return docsAsMaps;
}

Future<List<Map<String, dynamic>>> getFavoriteAdsFromUser(String userId,
    {fromServer = false}) async {
  Query query =
      Firestore().collection("ads").where("favored", arrayContains: userId);

  List<Map<String, dynamic>> docsAsMaps = await _fetchAds(query, fromServer);

  return docsAsMaps;
}

postNewAdToFavorites(String adId, String userId) async {
  await Firestore().collection("users").document(userId).updateData({
    "favorites": FieldValue.arrayUnion([adId])
  });
  await Firestore().collection("ads").document(adId).updateData({
    "favored": FieldValue.arrayUnion([userId])
  });
}

deleteAdFromFavorites(String adId, String userId) async {
  await Firestore().collection("users").document(userId).updateData({
    "favorites": FieldValue.arrayRemove([adId])
  });
  await Firestore().collection("ads").document(adId).updateData({
    "favored": FieldValue.arrayRemove([userId])
  });
}
