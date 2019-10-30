part of './twitter_api_client.dart';

Map<String, dynamic> _getInfoFromTweetText(String tweetText) {
  Map<String, dynamic> mapOfInfo = new Map();
  RegExp titleRegExp = new RegExp(r'^\*\*(.*)\*\*');
  RegExp categoryRegExp = new RegExp(r'__(.*)__');
  RegExp keywordRegExp = new RegExp(r'#(.*) ');
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
