part of 'retrieve_ads.dart';

Future<List<Ad>> getAdsAround(Map<String, double> position, double radius,
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

  List<Map<String, dynamic>> docsAsMaps = await _fetchAds(ref, fromServer);

  //Firebase doesn't currently curate with geo position, so we have to filter again.
  List<Ad> adsAround = [];
  docsAsMaps?.forEach((adAsMap) {
    Map<String, double> adLocationAsMap = {
      "latitude": adAsMap["location"].latitude,
      "longitude": adAsMap["location"].longitude
    };
    double distance = distanceInMetersBetween(adLocationAsMap, position);
    if (distance < 1000 * radius) {
      try {
        adsAround.add(Ad.fromJson(adAsMap));
      } catch (e) {}
    }
  });

  return adsAround;
}
