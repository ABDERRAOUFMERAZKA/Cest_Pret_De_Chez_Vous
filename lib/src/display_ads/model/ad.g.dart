// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ad _$AdFromJson(Map<String, dynamic> json) {
  return Ad(
    json['title'] as String,
    json['idStr'] as String,
    json['category'] as String,
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
      'category': instance.category,
      'authorId': instance.authorId,
      'picturesUrl': instance.picturesUrl,
      'keyWords': instance.keyWords,
      'description': instance.description,
      'geoLocation': instance.geoLocation,
    };
