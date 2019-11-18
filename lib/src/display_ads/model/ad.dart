import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../models/category.dart';

part 'ad.g.dart';

@JsonSerializable()
class Ad {
  final String title;
  final String idStr;
  final Category category;
  final String authorId;
  final List<String> picturesUrl;
  final List<String> keyWords;
  final String description;
  @JsonKey(fromJson: _positionFromFirebaseGeoPoint)
  final Position geoLocation;

  static Position _positionFromFirebaseGeoPoint(var geoPoint) {
    Position currentPosition =
        new Position(latitude: 48.8396952, longitude: 2.2399123);
    return currentPosition;
  }

  // String get title => _title;
  // String get idStr => _idStr;
  // Category get category => _category;
  // String get authorId => _authorId;
  // List<String> get picturesUrl => _picturesUrl;
  // List<String> get keyWords => _keyWords;
  // String get description => _description;
  // Geolocator get geoLocation => _geoLocation;

  Ad(this.title, this.idStr, this.category, this.authorId, this.picturesUrl,
      this.keyWords, this.description, this.geoLocation);

  factory Ad.fromJson(Map<String, dynamic> json) => _$AdFromJson(json);
}
