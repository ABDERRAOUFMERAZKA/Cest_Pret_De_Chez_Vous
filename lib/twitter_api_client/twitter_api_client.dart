import 'dart:convert';

import 'package:cest_pret_de_chez_vous/models/ad.dart';
import 'package:cest_pret_de_chez_vous/models/category.dart';
import 'package:oauth1/oauth1.dart';

part './tweet_from_ad.dart';
part './tweet_to_ad.dart';
part './twitter_api_client_utils.dart';

class TwitterApiClient extends Client {
  TwitterApiClient(
    SignatureMethod _signatureMethod,
    ClientCredentials _clientCredentials,
    Credentials _credentials,
  ) : super(_signatureMethod, _clientCredentials, _credentials);

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

  void postNewAd(Ad ad) {}
}
