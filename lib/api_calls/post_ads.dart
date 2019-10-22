part of './api_calls.dart';

class PostAds {
  /// throws BadParamException if Parameters are not valid
  /// and HttpException if the server gives an error
  static Future postAd(Ad ad) async {
    String email = ad.email;
    String phoneNumber = ad.phoneNumber;
    if (email == null && phoneNumber == null)
      throw new BadParameterException(
          "email and phone number cant be both null");
  }
}
