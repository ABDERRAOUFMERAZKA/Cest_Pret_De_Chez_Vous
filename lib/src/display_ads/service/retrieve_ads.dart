import 'package:cest_pret_de_chez_vous/utils/list_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/ad.dart';
import '../utils/geo_compute.dart';

part 'ads_around.dart';
part 'ads_from_user.dart';
part 'favorite_ads.dart';

Future<List<Map<String, dynamic>>> _fetchAds(
    Query query, bool fromServer) async {
  var response = await query
      .orderBy("createdAt")
      .getDocuments(source: fromServer ? Source.serverAndCache : Source.cache);
  var documents = response.documents;
  List<Map<String, dynamic>> docsAsMaps = [];
  documents.forEach((document) {
    Map docAsMap = document.data;
    docAsMap["category"] = docAsMap["category"].toUpperCase();
    docsAsMaps.add(docAsMap);
  });

  docsAsMaps?.sort((var ad1, var ad2) {
    if (ad1["createdAt"] != null && ad2["createdAt"] != null)
      return -ad1["createdAt"].compareTo(ad2["createdAt"]);
    return 1;
  });

  return docsAsMaps;
}
