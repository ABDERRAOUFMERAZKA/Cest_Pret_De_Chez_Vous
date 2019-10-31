import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import './category.dart';
import './user.dart';

part 'ad.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Ad {
  final String _title;
  final String _idStr;
  final Category _category;
  final User _user;
  final DateTime _createdAt;
  final List<String> _picturesUrl;
  final List<String> _keyWords;
  final String _description;
  final String _locationAsNumberString;

  String get title => _title;
  String get idStr => _idStr;
  Category get category => _category;
  User get user => _user;
  DateTime get createdAt => _createdAt;
  List<String> get picturesUrl => _picturesUrl;
  List<String> get keyWords => _keyWords;
  String get description => _description;
  String get locationAsNumberString => _locationAsNumberString;

  Ad(
      {@required title,
      @required idStr,
      @required category,
      @required user,
      @required createdAt,
      @required picturesUrl,
      @required keyWords,
      @required description,
      @required locationAsNumberString})
      : _title = title,
        _idStr = idStr,
        _category = category,
        _user = user,
        _createdAt = createdAt,
        _picturesUrl = picturesUrl,
        _keyWords = keyWords,
        _description = description,
        _locationAsNumberString = locationAsNumberString;

  //factory Ad.fromJson(Map<String, dynamic> json) => _$AdFromJson(json);

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
      title: json['title'],
      idStr: json['idStr'],
      category: getCategoryFromString(json['category']),
      user: User.fromJson(json['user']),
      createdAt: json['createdAt'],
      picturesUrl: json['picturesUrl'],
      keyWords: json['keyWords'],
      description: json['description'],
      locationAsNumberString: json['locationAsNumberString']);

  Map<String, dynamic> toJson() => _$AdToJson(this);
}
