import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ad.g.dart';

@JsonSerializable()
class Ad {
  final String title;
  final String idStr;
  final String category;
  final String authorId;
  final List<String> picturesUrl;
  final List<String> keywords;
  final List<String> favored;
  final String description;
  @JsonKey(fromJson: _positionFromFirebaseGeoPoint)
  final Position geoLocation;

  static Position _positionFromFirebaseGeoPoint(var geoPoint) {
    Position currentPosition =
        new Position(latitude: 48.8396952, longitude: 2.2399123);
    return currentPosition;
  }

  Ad(this.title, this.idStr, this.category, this.authorId, this.picturesUrl,
      this.keywords, this.favored, this.description, this.geoLocation);

  factory Ad.fromJson(Map<String, dynamic> json) => _$AdFromJson(json);

  Map<String, dynamic> toJson() => _$AdToJson(this);
}
