import 'dart:math';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cest_pret_de_chez_vous/utils/string_generator.dart';

import '../utils/geo_compute.dart';

Future<List<Map<String, dynamic>>> _fetchAds(
    Query query, bool fromServer) async {
  var response = await query.getDocuments(
      source: fromServer ? Source.serverAndCache : Source.cache);
  var documents = response.documents;
  List<Map<String, dynamic>> docsAsMaps = [];
  documents.forEach((document) {
    Map docAsMap = document.data;
    docAsMap["idStr"] = document.documentID;
    docsAsMaps.add(docAsMap);
  });
  return docsAsMaps;
}

Future<List<Map<String, dynamic>>> getAdsAround(
    Map<String, double> position, double radius,
    {bool fromServer = false}) async {
  GeoPoint positionAsGeoPoint =
      GeoPoint(position["latitude"], position["longitude"]);

  Map<String, GeoPoint> boundingBox = boundingBoxCoordinates(
      positionAsGeoPoint.latitude, positionAsGeoPoint.longitude, radius);

  Query ref = Firestore()
      .collection("ads")
      .where("location", isGreaterThan: boundingBox["swCorner"])
      .where("location", isLessThan: boundingBox["neCorner"]);

  //Firebase doesn't currently curate with geo position, so we have to filter again.
  List<Map<String, dynamic>> adsAround =
      (await _fetchAds(ref, fromServer)).where((ad) {
    double distance =
        distanceInMetersBetween(ad["location"], positionAsGeoPoint);
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

Future populateTable() async {
  var categories = ["book", "kitchen", "electronic"];
  double minWest = 2.228833;
  double maxEast = 2.254857;
  double minSouth = 48.82882;
  double maxNorth = 48.845492;
  String authorId = (await FirebaseAuth.instance.currentUser()).uid;
  final _random = new Random();
  for (var i = 0; i < 1000; i++) {
    String title = "Title $i";
    String category = categories[i % 3];
    String description =
        "This is a random description for add $i and yes i don't know what to add, but... yeah...";
    double latitude = minSouth + _random.nextDouble() * (maxNorth - minSouth);
    double longitude = minWest + _random.nextDouble() * (maxEast - minWest);
    var docRef = await Firestore().collection("ads").add({
      "authorId": authorId,
      "category": category,
      "title": title,
      "description": description,
      "keywords": ["keyword1"],
      "picturesUrl": [],
      "location": GeoPoint(latitude, longitude)
    });
    docRef.updateData({"adId": docRef.documentID});
  }
  print("done");
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
