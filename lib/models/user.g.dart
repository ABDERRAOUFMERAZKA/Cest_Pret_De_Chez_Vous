// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    name: json['name'],
    login: json['login'],
    description: json['description'],
    profilePictureUrl: json['profilePictureUrl'],
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'login': instance.login,
      'description': instance.description,
      'profilePictureUrl': instance.profilePictureUrl,
    };
