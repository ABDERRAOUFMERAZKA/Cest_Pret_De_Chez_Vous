import 'dart:convert';

import 'package:cest_pret_de_chez_vous/exceptions/bad_parameters_exception.dart';
import 'package:cest_pret_de_chez_vous/models/ad.dart';
import 'package:cest_pret_de_chez_vous/models/category.dart';
import 'package:oauth1/oauth1.dart';

Uri _getUrlFromCategoryAndLocation() {
  return (Uri.parse(
      "https://api.twitter.com/1.1/collections/entries.json?id=custom-1187319392239009792&tweet_mode=extended"));
}

class TwitterApiClient extends Client {
  TwitterApiClient(
    SignatureMethod _signatureMethod,
    ClientCredentials _clientCredentials,
    Credentials _credentials,
  ) : super(_signatureMethod, _clientCredentials, _credentials);

  Future<List<Ad>> fetchCollection(
      {Category category,
      List<String> keyWords,
      String locationAsNumberString}) async {
    Uri url = _getUrlFromCategoryAndLocation();
    var response = await super.get(url);
    Map<String, dynamic> mapResponse = jsonDecode(response.body);

    List<Map<String, dynamic>> timeline = mapResponse["response"]["timeline"];
    Map<String, dynamic> tweets = mapResponse["objects"]["tweets"];
    Map<String, dynamic> users = mapResponse["objects"]["users"];

    List<Ad> listOfAds = [];

    for (var item in timeline) {
      final tweetIdStr = item["tweet"]["id_str"];
      final tweet = tweets[tweetIdStr];
      final user = users[tweet["user"]["id_str"]];
      listOfAds.add(Ad.fromJsonAndUser(tweet, user));
    }

    print("first user: $mapResponse");
  }

  void postNewAd(Ad ad) {
    if (ad.email == null && ad.phoneNumber == null) {
      throw new BadParameterException(
          "email and phone number cannot both be null");
    } else {}
  }
}
