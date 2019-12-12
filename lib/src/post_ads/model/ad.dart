import 'package:cest_pret_de_chez_vous/src/category.dart';
import 'package:cest_pret_de_chez_vous/utils/enum_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ad.g.dart';

@JsonSerializable()
class Ad {
  @JsonKey(nullable: false)
  final String title;

  @JsonKey(
      nullable: false, fromJson: _categoryFromString, toJson: _categoryToString)
  final Category category;

  @JsonKey(nullable: true)
  final List<String> picturesUrl;

  @JsonKey(nullable: false)
  final List<String> keywords;

  @JsonKey(nullable: true)
  final String description;

  @JsonKey(nullable: false)
  final double latitude;

  @JsonKey(nullable: false)
  final double longitude;

  Ad(this.title, this.category, this.picturesUrl, this.keywords,
      this.description, this.latitude, this.longitude);

  factory Ad.fromJson(Map<String, dynamic> json) => _$AdFromJson(json);

  Map<String, dynamic> toJson() => _$AdToJson(this);

  static String _categoryToString(Category category) =>
      EnumToString.parse(category);
  static Category _categoryFromString(String string) =>
      EnumToString.fromString(Category.values, string);
}
