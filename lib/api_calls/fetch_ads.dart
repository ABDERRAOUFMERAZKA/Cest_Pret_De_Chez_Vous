part of './api_calls.dart';

class FetchAds {
  /// fetch function for home screen
  /// returns latest ads in provided location
  static Future<List<Ad>> loadHome({@required String locationAsNumber}) async {
    return dummyListOfAds
        .where((Ad ad) => ad.locationAsNumber == locationAsNumber);
  }

  /// fetch function for search screen
  /// returns latest ads in provided location and satisfying parameters
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
