part of './api_calls.dart';

class FetchAds {
  static Future<List<Ad>> loadHome({@required String locationAsNumber}) async {
    return dummyListOfAds
        .where((Ad ad) => ad.locationAsNumber == locationAsNumber);
  }

  static Future<List<Ad>> search(
      {@required Category category,
      @required List<String> keyWords,
      @required String locationAsNumber}) async {
    return dummyListOfAds.where((Ad ad) =>
        (ad.locationAsNumber == locationAsNumber) &&
        ad.keyWords.contains(keyWords) &&
        ad.category == category);
  }
}
