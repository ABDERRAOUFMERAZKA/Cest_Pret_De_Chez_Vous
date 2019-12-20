part of 'retrieve_ads.dart';

Future<List<Ad>> getFavoriteAdsFromUser(String userId,
    {fromServer = false}) async {
  Query query =
      Firestore().collection("ads").where("favored", arrayContains: userId);

  List<Map<String, dynamic>> docsAsMaps = await _fetchAds(query, fromServer);

  List<Ad> favoriteAds = [];
  docsAsMaps?.forEach((adAsMap) {
    try {
      favoriteAds.add(Ad.fromJson(adAsMap));
    } catch (e) {}
  });

  return favoriteAds;
}

Future<void> postNewAdToFavorites(String adId, String userId) async {
  await Firestore().collection("users").document(userId).updateData({
    "favorites": FieldValue.arrayUnion([adId])
  });
  await Firestore().collection("ads").document(adId).updateData({
    "favored": FieldValue.arrayUnion([userId])
  });
}

Future<void> deleteAdFromFavorites(String adId, String userId) async {
  await Firestore().collection("users").document(userId).updateData({
    "favorites": FieldValue.arrayRemove([adId])
  });
  await Firestore().collection("ads").document(adId).updateData({
    "favored": FieldValue.arrayRemove([userId])
  });
}
