part of './twitter_api.dart';

_getTweetTextFromJson(String title, String category, List<String> keywords,
    String locationAsNumberString, String description) {
  return "[$title]\n__$category\__\n${keywords.join(' ')}\n//$locationAsNumberString\//\n$description";
}

Map<String, String> _getParamsFromAd(Ad ad) {
  Map<String, String> paramsAsMap = new Map();
  String tweetText = _getTweetTextFromJson(ad.title, ad.category.toString(),
      ad.keyWords, ad.locationAsNumberString, ad.description);
  print(tweetText);
  paramsAsMap['status'] = tweetText;
  if (ad.picturesUrl != null) {
    String picturesUrlAsString = ad.picturesUrl.join(',');
    paramsAsMap['media_urls'] = picturesUrlAsString;
  }
  return paramsAsMap;
}
