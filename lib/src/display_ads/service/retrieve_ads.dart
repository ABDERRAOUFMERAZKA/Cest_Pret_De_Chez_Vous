import '../utils/geohashes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/ad.dart';

Future<List<Ad>> fetchAds(GeoPoint geoPoint, double radius) async {
  var boundingBox =
      boundingBoxCoordinates(geoPoint.latitude, geoPoint.longitude, radius);
  Firestore()
      .collection("ads")
      .where("location", isGreaterThanOrEqualTo: boundingBox[""])
      .where("field", isLessThanOrEqualTo: boundingBox[""])
      .getDocuments();
  return [];
}

//Future<List<Ad>> fetchAds(GeoPoint geoPoint, List<String> keywords) async {}
