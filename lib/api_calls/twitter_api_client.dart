import 'dart:convert';

import 'package:cest_pret_de_chez_vous/exceptions/bad_parameters_exception.dart';
import 'package:cest_pret_de_chez_vous/models/ad.dart';
import 'package:cest_pret_de_chez_vous/models/category.dart';
import 'package:oauth1/oauth1.dart';

import './api_calls.dart';

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
    return await FetchAds.search(
        category: category,
        keyWords: keyWords,
        locationAsNumberString: locationAsNumberString);
  }

  void postNewAd(Ad ad) {
    if (ad.email == null && ad.phoneNumber == null) {
      throw new BadParameterException(
          "email and phone number cannot both be null");
    } else {}
  }
}
