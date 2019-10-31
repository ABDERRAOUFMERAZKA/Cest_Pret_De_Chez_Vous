part of './twitter_api_client.dart';

String _getTweetTextFromJson(String title, String category,
    List<String> keywords, String locationAsNumberString, String description) {
  return "\*\*$title\*\*\n__$category\_\_\n${keywords.join(' ')}\n\/\/$locationAsNumberString\/\/\n$description";
}

Map<String, dynamic> _getTweetFromAd(Ad ad) {
  Map<String, dynamic> tweetMap = new Map();
  tweetMap['text'] = _getTweetTextFromJson(ad.title, ad.category.toString(),
      ad.keyWords, ad.locationAsNumberString, ad.description);
  return tweetMap;
}
