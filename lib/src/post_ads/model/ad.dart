import 'package:cest_pret_de_chez_vous/src/category.dart';
import 'package:cest_pret_de_chez_vous/utils/enum_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ad.g.dart';

@JsonSerializable()
class Ad {
  final String title;
  @JsonKey(fromJson: _categoryFromString, toJson: _categoryToString)
  final Category category;
  final List<String> picturesUrl;
  final List<String> keywords;
  final String description;
  final double latitude;
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
