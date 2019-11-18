// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ad _$AdFromJson(Map<String, dynamic> json) {
  return Ad(
    json['title'] as String,
    json['idStr'] as String,
    _$enumDecodeNullable(_$CategoryEnumMap, json['category']),
    json['authorId'] as String,
    (json['picturesUrl'] as List)?.map((e) => e as String)?.toList(),
    (json['keyWords'] as List)?.map((e) => e as String)?.toList(),
    json['description'] as String,
    Ad._positionFromFirebaseGeoPoint(json['geoLocation']),
  );
}

Map<String, dynamic> _$AdToJson(Ad instance) => <String, dynamic>{
      'title': instance.title,
      'idStr': instance.idStr,
      'category': _$CategoryEnumMap[instance.category],
      'authorId': instance.authorId,
      'picturesUrl': instance.picturesUrl,
      'keyWords': instance.keyWords,
      'description': instance.description,
      'geoLocation': instance.geoLocation,
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

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$CategoryEnumMap = {
  Category.book: 'book',
  Category.kitchen: 'kitchen',
  Category.stationery: 'stationery',
  Category.electronic: 'electronic',
};
