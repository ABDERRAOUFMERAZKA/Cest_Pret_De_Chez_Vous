import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../model/ad.dart';
import '../services/post_ad_services.dart';
import '../../category.dart';

class PostAdViewModel with ChangeNotifier {
  Future<List<String>> _uploadPictures(List<File> picturesLoaded) async {
    return await pickSaveImage(picturesLoaded);
  }

  Future<void>postAd({List<String> keywords, Category category, String title, String description, List<File> picturesLoaded}) async{
    List<String> picturesUrls = await _uploadPictures(picturesLoaded);
    Position geoLocation = await Geolocator().getCurrentPosition();
    Ad ad = new Ad(title, category, picturesUrls, keywords, description, geoLocation.latitude, geoLocation.longitude);
    uploadAd(ad);
  }
}