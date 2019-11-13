import 'package:geolocator/geolocator.dart';

import '../../../models/category.dart';
import './user.dart';

class Ad {
  final String _title;
  final String _idStr;
  final Category _category;
  final User _author;
  final List<String> _picturesUrl;
  final List<String> _keyWords;
  final String _description;
  final Geolocator _locationAsNumber;

  String get title => _title;
  String get idStr => _idStr;
  Category get category => _category;
  User get author => _author;
  List<String> get picturesUrl => _picturesUrl;
  List<String> get keyWords => _keyWords;
  String get description => _description;
  Geolocator get locationAsNumber => _locationAsNumber;

  Ad(this._title, this._idStr, this._category, this._author, this._picturesUrl,
      this._keyWords, this._description, this._locationAsNumber);
}
