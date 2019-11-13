import 'dart:math';

import '../utils/geohashes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> fetchAllAdsAround(
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
