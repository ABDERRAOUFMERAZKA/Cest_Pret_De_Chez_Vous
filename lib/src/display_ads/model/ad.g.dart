// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ad _$AdFromJson(Map<String, dynamic> json) {
  return Ad(
    json['title'] as String,
    json['adId'] as String,
    json['category'] as String,
    json['authorId'] as String,
    (json['picturesUrl'] as List)?.map((e) => e as String)?.toList(),
    (json['keywords'] as List)?.map((e) => e as String)?.toList(),
    (json['favored'] as List)?.map((e) => e as String)?.toList(),
    json['description'] as String,
    Ad._positionFromFirebaseGeoPoint(json['location']),
    json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );
}

Map<String, dynamic> _$AdToJson(Ad instance) => <String, dynamic>{
      'title': instance.title,
      'adId': instance.adId,
      'category': instance.category,
      'authorId': instance.authorId,
      'picturesUrl': instance.picturesUrl,
      'keywords': instance.keywords,
      'favored': instance.favored,
      'description': instance.description,
      'location': instance.geoLocation,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
