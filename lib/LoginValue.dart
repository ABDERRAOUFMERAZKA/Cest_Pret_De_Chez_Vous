import 'package:flutter/material.dart';

class LoginValue with ChangeNotifier {
  bool _isLogged = false;
  bool get isLogged => _isLogged;
  void updateIsLogged(bool isLogged){
    this._isLogged = isLogged;
    notifyListeners();
  }
}