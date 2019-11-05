part of './twitter_api.dart';

Map<String, dynamic> _getInfoFromTweetText(String tweetText) {
  Map<String, dynamic> mapOfInfo = new Map();
  RegExp titleRegExp = new RegExp(r'^\[(.*)\]');
  RegExp categoryRegExp = new RegExp(r'__(.*)__');
  RegExp locationRegExp = new RegExp(r'\/\/location: (.*)\/\/');

  mapOfInfo['title'] = titleRegExp.firstMatch(tweetText).group(0);
  mapOfInfo['category'] = categoryRegExp.firstMatch(tweetText).group(0);
  mapOfInfo['locationAsNumberString'] =
      locationRegExp.firstMatch(tweetText).group(0);

  return mapOfInfo;
}

Ad _getAdFromTweetMap(
    Map<String, dynamic> tweetMap, Map<String, dynamic> userMap) {
  Map<String, dynamic> adMap = new Map();

  // flatten map to be usable by constructor
  adMap.addAll(_getInfoFromTweetText(tweetMap['full_text']));
  adMap['keyWords'] = new List<String>();
  var hashtags = tweetMap['entities']['hashtags'];
  for (var hashtag in hashtags) {
    adMap['keyWords'].add(hashtag['text']);
  }
  adMap['picturesUrl'] = new List<String>();
  var media = tweetMap['entities']['media'];
  if (media != null)
    for (var medium in media) {
      adMap['picturesUrl'].add(medium['media_url_https']);
    }
  adMap['user'] = userMap;
  return Ad.fromJson(adMap);
}

Uri _getCollectionUrlFromCategoryAndLocation() {
  return (Uri.parse(
      "https://api.twitter.com/1.1/collections/entries.json?id=custom-1189564932402143233&tweet_mode=extended"));
}

List<Ad> _getListOfAdsFromJson(Map<String, dynamic> mapResponse) {
  List<dynamic> timeline = mapResponse["response"]["timeline"];
  var objects = mapResponse["objects"];
  Map<String, dynamic> tweets = objects["tweets"];
  Map<String, dynamic> users = objects["users"];

  List<Ad> listOfAds = [];

  for (var item in timeline) {
    final String tweetIdStr = item["tweet"]["id"];
    final Map<String, dynamic> tweet = tweets[tweetIdStr];
    final Map<String, dynamic> user = users[tweet["user"]["id_str"]];
    listOfAds.add(_getAdFromTweetMap(tweet, user));
  }

  return listOfAds;
}
