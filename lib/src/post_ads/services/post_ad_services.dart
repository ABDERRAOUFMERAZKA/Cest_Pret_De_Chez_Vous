import 'dart:io';
import 'dart:math';

import 'package:cest_pret_de_chez_vous/utils/random_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

Future populateTable() async {
  var categories = ["BOOK", "KITCHEN", "ELECTRONIC"];
  double minWest = 1.829079;
  double maxEast = 2.516978;
  double minSouth = 48.643868;
  double maxNorth = 49.003630;
  String authorId = (await FirebaseAuth.instance.currentUser()).uid;
  final _random = new Random();
  for (var i = 0; i < 1000; i++) {
    String title = "Title $i";
    String category = categories[i % 3];
    String description =
        "This is a random description for add $i and yes i don't know what to say, but... yeah...";
    double latitude = minSouth + _random.nextDouble() * (maxNorth - minSouth);
    double longitude = minWest + _random.nextDouble() * (maxEast - minWest);
    var docRef = await Firestore().collection("ads").add({
      "title": title,
      "category": category,
      "authorId": authorId,
      "picturesUrl": [],
      "keywords": ["keyword1"],
      "favored": [],
      "description": description,
      "location": GeoPoint(latitude, longitude),
      "createdAt": randomDate(DateTime(2015, 1), DateTime(2019, 11)),
    });
    docRef.updateData({"adId": docRef.documentID});
  }
}
