// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ad _$AdFromJson(Map<String, dynamic> json) {
  return Ad(
    json['title'] as String,
    json['adId'] as String,
    _$enumDecode(_$CategoryEnumMap, json['category']),
    json['authorId'] as String,
    (json['picturesUrl'] as List)?.map((e) => e as String)?.toList(),
    (json['keywords'] as List).map((e) => e as String).toList(),
    (json['favored'] as List)?.map((e) => e as String)?.toList(),
    json['description'] as String,
    Ad._positionFromFirebaseGeoPoint(json['location']),
    Ad._dateTimeFromFirebaseTimestamp(json['createdAt']),
  );
}

Map<String, dynamic> _$AdToJson(Ad instance) => <String, dynamic>{
      'title': instance.title,
      'adId': instance.adId,
      'category': _$CategoryEnumMap[instance.category],
      'authorId': instance.authorId,
      'keywords': instance.keywords,
      'picturesUrl': instance.picturesUrl,
      'favored': instance.favored,
      'description': instance.description,
      'location': instance.geoLocation,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

const _$CategoryEnumMap = {
  Category.BOOK: 'BOOK',
  Category.KITCHEN: 'KITCHEN',
  Category.ELECTRONIC: 'ELECTRONIC',
};
