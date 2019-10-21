part of './api_calls.dart';

class FetchUsers {
  static User fetchUser({@required String login}) {
    return users.firstWhere((User user) => user.login == login);
  }
}

final List<User> users = [
  User(
    name: "Baptiste Desjobert",
    login: "Bapth-dej",
    bio: "I am Baptiste Desjobert, and i like french fries.",
    profilePictureUrl:
        "https://pbs.twimg.com/profile_images/1185188036247785472/OE60ihXc_400x400.jpg",
  ),
];
