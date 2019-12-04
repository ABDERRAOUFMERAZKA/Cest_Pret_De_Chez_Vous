import 'dart:io';
import 'package:cest_pret_de_chez_vous/utils/random_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/ad.dart';

Future<List<String>> savePictureInDatabase(List<File> picturesLoaded) async {
  if (picturesLoaded != null) {
    List<String> urls = [];
    for (var picture in picturesLoaded) {
      if (picture != null) {
        StorageReference ref =
            FirebaseStorage.instance.ref().child(randomString(20));
        StorageUploadTask uploadTask = ref.putFile(picture);
        urls.add(await (await uploadTask.onComplete).ref.getDownloadURL());
      }
    }
    return urls;
  }
  return null;
}

Future<String> uploadAd(Ad ad, String userId) async {
  Map<String, dynamic> adMap = ad.toJson();
  try {
    // create GeoPoint from latitude and longitude and remove them from map
    adMap["location"] = GeoPoint(adMap["latitude"], adMap["longitude"]);
    adMap.remove("latitude");
    adMap.remove("longitude");
    DocumentReference docRef = await Firestore().collection("ads").add(adMap);
    docRef.updateData({
      "authorId": userId,
      "adId": docRef.documentID,
      "favored": [],
    });
    return "OK";
  } catch (e) {
    return e.code;
  }
}
