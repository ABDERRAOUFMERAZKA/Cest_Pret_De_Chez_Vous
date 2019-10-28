import 'dart:io';

import 'package:cest_pret_de_chez_vous/exceptions/bad_parameters_exception.dart';
import 'package:cest_pret_de_chez_vous/models/ad.dart';
import 'package:cest_pret_de_chez_vous/models/category.dart';
import 'package:cest_pret_de_chez_vous/models/user.dart';
import 'package:meta/meta.dart';

part './fetch_ads.dart';
part './fetch_users.dart';
part './post_ads.dart';

final List<Ad> dummyListOfAds = [
  Ad(
      title: "My first 92 Ad",
      idStr: "ABC",
      category: Category.book,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["first", "book", "nemo"],
      description: "this first ad is about giving away my first book : Nemo.",
      phoneNumber: null,
      email: "dummy@email.com",
      locationAsNumberString: "92"),
  Ad(
      title: "My second 92 Ad",
      idStr: "BCD",
      category: Category.kitchen,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["kitchen", "fork", "golden"],
      description:
          "I am giving away my golden fork because I don\'t need it anymore",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumberString: "92"),
  Ad(
      title: "My third 92 Ad",
      idStr: "CDE",
      category: Category.stationery,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["pen", "blue"],
      description: "I have a blue pen, but I only use my computer now",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumberString: "92"),
  Ad(
      title: "My fourth 92 Ad",
      idStr: "DEF",
      category: Category.electronic,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["phone", "charger", "microUSB"],
      description:
          "I recently bought an iPhone, so I won\'t be needing this charger anymore.",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumberString: "92"),
  Ad(
      title: "My first 78 Ad",
      idStr: "EFG",
      category: Category.book,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["child", "children"],
      description: "Book for children : Jason and the Argonautes",
      phoneNumber: null,
      email: "dummy@email.com",
      locationAsNumberString: "78"),
  Ad(
      title: "My second 78 Ad",
      idStr: "FGH",
      category: Category.kitchen,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["spoon", "silver"],
      description: "I have a sliver spoon, not where you think.",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumberString: "78"),
  Ad(
      title: "My third 78 Ad",
      idStr: "GHI",
      category: Category.stationery,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["scissors", "red"],
      description: "giving away my red scissors, right and left-handed",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumberString: "78"),
  Ad(
      title: "My fourth 78 Ad",
      idStr: "HIJ",
      category: Category.electronic,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["toaster"],
      description: "I am gluten intolerant and don\'t need this toaster.",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumberString: "78"),
  Ad(
      title: "My first 95 Ad",
      idStr: "IJK",
      category: Category.book,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["manga", "naruto"],
      description:
          "I am giving my Naruto collection i was disappointed by the end :(",
      phoneNumber: null,
      email: "dummy@email.com",
      locationAsNumberString: "95"),
  Ad(
      title: "My second 95 Ad",
      idStr: "JKL",
      category: Category.kitchen,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["titanium", "knife"],
      description: "Titanium knife, very useful for cutting Fish",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumberString: "95"),
  Ad(
      title: "My third 95 Ad",
      idStr: "KLM",
      category: Category.stationery,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["paper", "stack"],
      description:
          "do you need paper for your printing machine ? I have a whole stack !",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumberString: "95"),
  Ad(
      title: "My fourth 95 Ad",
      idStr: "LMN",
      category: Category.electronic,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["airpods", "earphones", "wireless"],
      description: "these airpods are very good, but I like cables (?)",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumberString: "95"),
];

final List<User> users = [
  User(
    name: "Baptiste Desjobert",
    login: "Bapth-dej",
    bio: "I am Baptiste Desjobert, and i like french fries.",
    profilePictureUrl:
        "https://pbs.twimg.com/profile_images/1185188036247785472/OE60ihXc_400x400.jpg",
  ),
];
