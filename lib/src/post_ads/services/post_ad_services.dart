import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../model/ad.dart';

Future<List<String>> savePicturesInDatabase(List<File> picturesLoaded) async {
  Uuid uuid = Uuid();
  if (picturesLoaded != null) {
    List<String> urls = [];
    for (var picture in picturesLoaded) {
      if (picture != null) {
        StorageReference ref = FirebaseStorage.instance.ref().child(uuid.v4());
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
