import 'dart:io';
import 'package:cest_pret_de_chez_vous/utils/string_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/ad.dart';

Future<List<String>>pickSaveImage(List<File> picturesLoaded) async {
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
    print('image url: $urls');
    return urls;
  } return null;
}

Future<String>uploadAd(Ad ad) async{
  Map<String, dynamic> adMap = ad.toJson();
  var docRef = await Firestore().collection("ads").add(adMap);
  return docRef.documentID;
}