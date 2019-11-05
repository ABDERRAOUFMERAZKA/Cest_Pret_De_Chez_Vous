import 'package:cest_pret_de_chez_vous/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:oauth1/oauth1.dart';

class LoginValue with ChangeNotifier {
  bool _isLogged = false;
  Client _client;

  bool get isLogged => _isLogged;
  Client get client => _client;

  void updateIsLogged(bool isLogged) {
    this._isLogged = isLogged;
    notifyListeners();
  }

  void updateClient(TwitterApiClient client) {
    this._client = client;
  }
}
