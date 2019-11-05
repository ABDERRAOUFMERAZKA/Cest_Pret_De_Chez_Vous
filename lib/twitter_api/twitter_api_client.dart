part of './twitter_api.dart';

class TwitterApiClient extends Client {
  TwitterApiClient(
    Credentials _credentials,
  ) : super(
          SignatureMethods.hmacSha1,
          ClientCredentials(_CONSUMER_KEY, _CONSUMER_SECRET),
          _credentials,
        );

  Future<List<Ad>> fetchAds(
      {Category category,
      List<String> keyWords,
      String locationAsNumberString}) async {
    Uri url = _getCollectionUrlFromCategoryAndLocation();
    var response = await super.get(url);
    Map<String, dynamic> mapResponse = jsonDecode(response.body);

    var listOfAds = _getListOfAdsFromJson(mapResponse);
    return listOfAds;
  }

  void postNewAd(Ad ad) async {
    var params = _getParamsFromAd(ad);
    Uri url = Uri.parse("https://api.twitter.com/1.1/statuses/update.json");
    print(params.toString());
    var response = await super.post(url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: params);
    print(response.body);
  }
}
