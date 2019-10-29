import 'package:cest_pret_de_chez_vous/models/user.dart';
import 'package:meta/meta.dart';

import './category.dart';

class Ad {
  final String _title;
  final String _idStr;
  final Category _category;
  final User _user;
  final DateTime _createdAt;
  final List<String> _picturesUrl;
  final List<String> _keyWords;
  final String _description;
  final String _phoneNumber;
  final String _email;
  final String _locationAsNumberString;

  String get title => _title;
  String get idStr => _idStr;
  Category get category => _category;
  User get user => _user;
  DateTime get createdAt => _createdAt;
  List<String> get picturesUrl => _picturesUrl;
  List<String> get keyWords => _keyWords;
  String get description => _description;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
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
      @required phoneNumber,
      @required email,
      @required locationAsNumberString})
      : _title = title,
        _idStr = idStr,
        _category = category,
        _user = user,
        _createdAt = createdAt,
        _picturesUrl = picturesUrl,
        _keyWords = keyWords,
        _description = description,
        _phoneNumber = phoneNumber,
        _email = email,
        _locationAsNumberString = locationAsNumberString;

  factory Ad.fromJsonAndUser(Map<String, dynamic> json, User user) {
    return Ad(
      title: json[''],
      idStr: json[''],
      category: json[''],
      user: user,
      createdAt: DateTime.parse(json['']),
      picturesUrl: json[''],
      keyWords: json[''],
      description: json[''],
      phoneNumber: json[''],
      email: json[''],
      locationAsNumberString: json[''],
    );
  }
}
