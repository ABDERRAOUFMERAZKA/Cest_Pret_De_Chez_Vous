import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ad.g.dart';

@JsonSerializable()
class Ad {
  final String title;
  final String adId;
  final String category;
  final String authorId;
  final List<String> picturesUrl;
  final List<String> keywords;
  final List<String> favored;
  final String description;
  @JsonKey(fromJson: _positionFromFirebaseGeoPoint, name: "location")
  final Position geoLocation;
  final DateTime createdAt;

  static Position _positionFromFirebaseGeoPoint(var geoPoint) {
    Position currentPosition = new Position(
        latitude: geoPoint.latitude, longitude: geoPoint.longitude);
    return currentPosition;
  }

  Ad(
      this.title,
      this.adId,
      this.category,
      this.authorId,
      this.picturesUrl,
      this.keywords,
      this.favored,
      this.description,
      this.geoLocation,
      this.createdAt);

  factory Ad.fromJson(Map<String, dynamic> json) => _$AdFromJson(json);

  Map<String, dynamic> toJson() => _$AdToJson(this);
}
