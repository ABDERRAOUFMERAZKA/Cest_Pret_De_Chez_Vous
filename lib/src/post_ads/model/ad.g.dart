// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ad _$AdFromJson(Map<String, dynamic> json) {
  return Ad(
    json['title'] as String,
    Ad._categoryFromString(json['category'] as String),
    (json['picturesUrl'] as List)?.map((e) => e as String)?.toList(),
    (json['keywords'] as List)?.map((e) => e as String)?.toList(),
    json['description'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$AdToJson(Ad instance) => <String, dynamic>{
      'title': instance.title,
      'category': Ad._categoryToString(instance.category),
      'picturesUrl': instance.picturesUrl,
      'keywords': instance.keywords,
      'description': instance.description,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
