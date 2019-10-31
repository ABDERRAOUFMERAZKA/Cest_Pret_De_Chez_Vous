import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: false, explicitToJson: true)
class User {
  final String _name;
  final String _login;
  final String _description;
  final String _profilePictureUrl;

  String get name => _name;
  String get login => _login;
  String get description => _description;
  String get profilePictureUrl => _profilePictureUrl;

  User(
      {@required name,
      @required login,
      @required description,
      @required profilePictureUrl})
      : _name = name,
        _login = login,
        _description = description,
        _profilePictureUrl = profilePictureUrl;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
