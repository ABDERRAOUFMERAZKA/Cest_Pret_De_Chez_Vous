part of './fetch_calls.dart';

class FetchTweets {
  static List<Ad> loadHome() {
    return [
      Ad(
          title: "My first Ad",
          category: Category.book,
          picturesUrl: [],
          keyWords: ["first", "book", ""],
          description: "this first ad is about giving away my first book",
          phoneNumber: null,
          email: "dummy@email.com"),
      Ad(
          title: "My second Ad",
          category: Category.kitchen,
          picturesUrl: [],
          keyWords: ["kitchen", "fork", "golden"],
          description:
              "I am giving away my golden fork because I don\'t need it anymore",
          phoneNumber: "0658237812",
          email: null),
    ];
  }
}
