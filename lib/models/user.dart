import 'package:meta/meta.dart';

class User {
  final String name;
  final String login;
  final String bio;
  final String profilePictureUrl;

  User({
    @required this.name,
    @required this.login,
    @required this.bio,
    @required this.profilePictureUrl,
  });
}
