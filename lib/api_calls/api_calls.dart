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
      category: Category.book,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["first", "book", "nemo"],
      description: "this first ad is about giving away my first book : Nemo.",
      phoneNumber: null,
      email: "dummy@email.com",
      locationAsNumber: "92"),
  Ad(
      title: "My second 92 Ad",
      category: Category.kitchen,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["kitchen", "fork", "golden"],
      description:
          "I am giving away my golden fork because I don\'t need it anymore",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumber: "92"),
  Ad(
      title: "My third 92 Ad",
      category: Category.stationery,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["pen", "blue"],
      description: "I have a blue pen, but I only use my computer now",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumber: "92"),
  Ad(
      title: "My fourth 92 Ad",
      category: Category.electronic,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["phone", "charger", "microUSB"],
      description:
          "I recently bought an iPhone, so I won\'t be needing this charger anymore.",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumber: "92"),
  Ad(
      title: "My first 78 Ad",
      category: Category.book,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["child", "children"],
      description: "Book for children : Jason and the Argonautes",
      phoneNumber: null,
      email: "dummy@email.com",
      locationAsNumber: "78"),
  Ad(
      title: "My second 78 Ad",
      category: Category.kitchen,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["spoon", "silver"],
      description: "I have a sliver spoon, not where you think.",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumber: "78"),
  Ad(
      title: "My third 78 Ad",
      category: Category.stationery,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["scissors", "red"],
      description: "giving away my red scissors, right and left-handed",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumber: "78"),
  Ad(
      title: "My fourth 78 Ad",
      category: Category.electronic,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["toaster"],
      description: "I am gluten intolerant and don\'t need this toaster.",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumber: "78"),
  Ad(
      title: "My first 95 Ad",
      category: Category.book,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["manga", "naruto"],
      description:
          "I am giving my Naruto collection i was disappointed by the end :(",
      phoneNumber: null,
      email: "dummy@email.com",
      locationAsNumber: "95"),
  Ad(
      title: "My second 95 Ad",
      category: Category.kitchen,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["titanium", "knife"],
      description: "Titanium knife, very useful for cutting Fish",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumber: "95"),
  Ad(
      title: "My third 95 Ad",
      category: Category.stationery,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["paper", "stack"],
      description:
          "do you need paper for your printing machine ? I have a whole stack !",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumber: "95"),
  Ad(
      title: "My fourth 95 Ad",
      category: Category.electronic,
      username: "Bapth-dej",
      picturesUrl: [],
      keyWords: ["airpods", "earphones", "wireless"],
      description: "these airpods are very good, but I like cables (?)",
      phoneNumber: "0658237812",
      email: null,
      locationAsNumber: "95"),
];
