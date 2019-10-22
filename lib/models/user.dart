import 'package:meta/meta.dart';

class User {
  final String _name;
  final String _login;
  final String _bio;
  final String _profilePictureUrl;

  String get name => _name;
  String get login => _login;
  String get bio => _bio;
  String get profilePictureUrl => _profilePictureUrl;

  User(
      {@required name,
      @required login,
      @required bio,
      @required profilePictureUrl})
      : _name = name,
        _login = login,
        _bio = bio,
        _profilePictureUrl = profilePictureUrl;
}
