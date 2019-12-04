import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../model/ad.dart';
import '../services/post_ad_services.dart';
import '../utils/firebase_responses.dart';
import '../../category.dart';

enum PostAdStatus { initialState, isLoading, isLoaded, onError }
enum ServerResponse { ok, platformError, otherError }

class PostAdViewModel with ChangeNotifier {
  PostAdStatus postAdStatus = PostAdStatus.initialState;
  String errorMessage;
  final String userId;

  Future<List<String>> _uploadPictures(List<File> picturesLoaded) async {
    return await savePictureInDatabase(picturesLoaded);
  }

  PostAdViewModel(this.userId);

  Future<void> postAd(
      {List<String> keywords,
      Category category,
      String title,
      String description,
      List<File> picturesLoaded}) async {
    this.postAdStatus = PostAdStatus.isLoading;
    notifyListeners();
    List<String> picturesUrls = await _uploadPictures(picturesLoaded);
    Position geoLocation = await Geolocator().getCurrentPosition();
    Ad ad = new Ad(title, category, picturesUrls, keywords, description,
        geoLocation.latitude, geoLocation.longitude);
    if (title != "") {
      String serverResponse = await uploadAd(ad);
      if (serverResponse == "OK") {
        this.postAdStatus = PostAdStatus.isLoaded;
        notifyListeners();
      } else {
        this.errorMessage =
            getErrorMessageFromFirebaseErrorCode(serverResponse);
        this.postAdStatus = PostAdStatus.onError;
        notifyListeners();
      }
    } else {
      this.errorMessage = "Please, fill all fields";
      this.postAdStatus = PostAdStatus.onError;
      notifyListeners();
    }
  }

  resetPostAdStatus() {
    this.postAdStatus = PostAdStatus.initialState;
    notifyListeners();
  }
}
