part of 'retrieve_ads.dart';

Future<List<Ad>> getAdsFromUser(String userId, {fromServer = false}) async {
  Query query =
      Firestore().collection("ads").where("authorId", isEqualTo: userId);

  List<Map<String, dynamic>> docsAsMaps = await _fetchAds(query, fromServer);

  List<Ad> adsFromUser = [];
  docsAsMaps?.forEach((adAsMap) {
    try {
      adsFromUser.add(Ad.fromJson(adAsMap));
    } catch (e) {}
  });

  return adsFromUser;
}
