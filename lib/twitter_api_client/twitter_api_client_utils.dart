part of './twitter_api_client.dart';

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
