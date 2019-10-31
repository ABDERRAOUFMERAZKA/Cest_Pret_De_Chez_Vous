// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ad _$AdFromJson(Map<String, dynamic> json) {
  return Ad(
    title: json['title'],
    idStr: json['idStr'],
    category: json['category'],
    user: json['user'],
    createdAt: json['createdAt'],
    picturesUrl: json['picturesUrl'],
    keyWords: json['keyWords'],
    description: json['description'],
    locationAsNumberString: json['locationAsNumberString'],
  );
}

Map<String, dynamic> _$AdToJson(Ad instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('idStr', instance.idStr);
  writeNotNull('category', _$CategoryEnumMap[instance.category]);
  writeNotNull('user', instance.user?.toJson());
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('picturesUrl', instance.picturesUrl);
  writeNotNull('keyWords', instance.keyWords);
  writeNotNull('description', instance.description);
  writeNotNull('locationAsNumberString', instance.locationAsNumberString);
  return val;
}

const _$CategoryEnumMap = {
  Category.book: 'book',
  Category.kitchen: 'kitchen',
  Category.stationery: 'stationery',
  Category.electronic: 'electronic',
};
