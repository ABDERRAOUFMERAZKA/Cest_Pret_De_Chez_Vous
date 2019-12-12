import 'package:cest_pret_de_chez_vous/src/category.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ad.g.dart';

@JsonSerializable()
class Ad {
  @JsonKey(nullable: false)
  final String title;

  @JsonKey(nullable: false)
  final String adId;

  @JsonKey(nullable: false)
  final Category category;

  @JsonKey(nullable: false)
  final String authorId;

  @JsonKey(nullable: false)
  final List<String> keywords;

  @JsonKey(nullable: true)
  final List<String> picturesUrl;

  @JsonKey(nullable: true)
  final List<String> favored;

  @JsonKey(nullable: true)
  final String description;

  @JsonKey(fromJson: _positionFromFirebaseGeoPoint, name: "location")
  final Position geoLocation;

  @JsonKey(fromJson: _dateTimeFromFirebaseTimestamp)
  final DateTime createdAt;

  static Position _positionFromFirebaseGeoPoint(var geoPoint) {
    Position currentPosition = new Position(
        latitude: geoPoint.latitude, longitude: geoPoint.longitude);
    return currentPosition;
  }

  static DateTime _dateTimeFromFirebaseTimestamp(var timestamp) {
    DateTime createdAt = timestamp.toDate();
    return createdAt;
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
