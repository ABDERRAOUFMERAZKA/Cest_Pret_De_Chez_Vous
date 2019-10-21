import 'package:meta/meta.dart';
import './category.dart';

class Ad {
  final String title;
  final Category category;
  final String username;
  final List<String> picturesUrl;
  final List<String> keyWords;
  final String description;
  final String phoneNumber;
  final String email;
  final String locationAsNumber;

  Ad({
    @required this.title,
    @required this.category,
    @required this.username,
    @required this.picturesUrl,
    @required this.keyWords,
    @required this.description,
    @required this.phoneNumber,
    @required this.email,
    @required this.locationAsNumber,
  });
}
