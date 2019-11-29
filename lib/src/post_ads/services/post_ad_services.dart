import 'dart:io';
import 'package:cest_pret_de_chez_vous/utils/string_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/ad.dart';
import '../view_model/post_ad_view_model.dart';

Future<List<String>>savePictureInDatabase(List<File> picturesLoaded) async {
  if (picturesLoaded != null) {
    List<String> urls = [];
    for (var picture in picturesLoaded) {
      if(picture != null){
        StorageReference ref =
        FirebaseStorage.instance.ref().child(randomString(20));
        StorageUploadTask uploadTask = ref.putFile(picture);
        urls.add(await (await uploadTask.onComplete).ref.getDownloadURL());
      }
    }
    return urls;
  } return null;
}

Future<String>uploadAd(Ad ad) async{
  Map<String, dynamic> adMap = ad.toJson();
  try {
    await Firestore().collection("ads").add(adMap);
    return "OK";
  } catch (e){
    return e.code;
  }
}
