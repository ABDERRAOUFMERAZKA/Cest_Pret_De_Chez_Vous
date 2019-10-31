part of './twitter_api_client.dart';

String _getTweetTextFromJson(String title, String category,
    List<String> keywords, String locationAsNumberString, String description) {
  return "\*\*$title\*\*\n__$category\_\_\n${keywords.join(' ')}\n\/\/$locationAsNumberString\/\/\n$description";
}

String _getParamsFromAd(Ad ad) {
  String paramsAsString = "";
  String tweetText = _getTweetTextFromJson(ad.title, ad.category.toString(),
      ad.keyWords, ad.locationAsNumberString, ad.description);
  paramsAsString += "status:$tweetText";
  if (ad.picturesUrl != null) {
    String picturesUrlAsString = ad.picturesUrl.join(',');
    paramsAsString += "&media_urls:$picturesUrlAsString";
  }
  return paramsAsString;
}
