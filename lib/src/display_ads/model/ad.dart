import 'package:meta/meta.dart';
import './category.dart';

class Ad {
  final String _title;
  final String _idStr;
  final Category _category;
  final String _username;
  final List<String> _picturesUrl;
  final List<String> _keyWords;
  final String _description;
  final String _phoneNumber;
  final String _email;
  final String _locationAsNumber;

  String get title => _title;
  String get idStr => _idStr;
  Category get category => _category;
  String get username => _username;
  List<String> get picturesUrl => _picturesUrl;
  List<String> get keyWords => _keyWords;
  String get description => _description;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
  String get locationAsNumber => _locationAsNumber;

  Ad(
      {@required title,
      @required idStr,
      @required category,
      @required username,
      @required picturesUrl,
      @required keyWords,
      @required description,
      @required phoneNumber,
      @required email,
      @required locationAsNumber})
      : _title = title,
        _idStr = idStr,
        _category = category,
        _username = username,
        _picturesUrl = picturesUrl,
        _keyWords = keyWords,
        _description = description,
        _phoneNumber = phoneNumber,
        _email = email,
        _locationAsNumber = locationAsNumber;
}
