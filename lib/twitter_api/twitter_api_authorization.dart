part of './twitter_api.dart';

class TwitterApiAuthorization extends Authorization {
  TwitterApiAuthorization()
      : super(ClientCredentials(_CONSUMER_KEY, _CONSUMER_SECRET), _PLATFORM);
}
