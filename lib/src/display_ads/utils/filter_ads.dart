import 'package:cest_pret_de_chez_vous/src/category.dart';
import 'package:cest_pret_de_chez_vous/utils/list_utils.dart';

import '../model/ad.dart';

class FilterAd {
  static List<Ad> filterAds(List<Ad> listOfAds,
      {Category category, List<String> keywords}) {
    List<Ad> filteredAds = [];
    if ((isNullOrEmpty(category)) && (isNullOrEmpty(keywords))) {
      filteredAds = listOfAds;
    } else if ((isNullOrEmpty(keywords))) {
      filteredAds = listOfAds.where((ad) => ad.category == category);
    } else if (category == null) {
      filteredAds = listOfAds
          .where((Ad ad) => listContainsAtLeastOneOf(ad.keywords, keywords))
          .toList();
    } else {
      filteredAds = listOfAds
          .where((Ad ad) =>
              listContainsAtLeastOneOf(ad.keywords, keywords) &&
              ad.category == category)
          .toList();
    }
    filteredAds.sort();
    return filteredAds;
  }
}
