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
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      locationAsNumberString: json['locationAsNumberString']);
}

Map<String, dynamic> _$AdToJson(Ad instance) => <String, dynamic>{
      'title': instance.title,
      'idStr': instance.idStr,
      'category': _$CategoryEnumMap[instance.category],
      'user': instance.user?.toJson(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'picturesUrl': instance.picturesUrl,
      'keyWords': instance.keyWords,
      'description': instance.description,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'locationAsNumberString': instance.locationAsNumberString
    };

const _$CategoryEnumMap = <Category, dynamic>{
  Category.book: 'book',
  Category.kitchen: 'kitchen',
  Category.stationery: 'stationery',
  Category.electronic: 'electronic'
};
