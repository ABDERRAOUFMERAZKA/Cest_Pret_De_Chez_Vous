part of './api_calls.dart';

class FetchAds {
  /// fetch function for home screen
  /// returns latest ads in provided location
  static Future<List<Ad>> loadHome(
      {@required String locationAsNumberString}) async {
    return dummyListOfAds
        .where((Ad ad) => ad.locationAsNumberString == locationAsNumberString);
  }

  /// fetch function for search screen
  /// returns latest ads in provided location and satisfying parameters
  static Future<List<Ad>> search(
      {@required Category category,
      @required List<String> keyWords,
      @required String locationAsNumberString}) async {
    return dummyListOfAds.where((Ad ad) =>
        (ad.locationAsNumberString == locationAsNumberString) &&
        ad.keyWords.contains(keyWords) &&
        ad.category == category);
  }
}
