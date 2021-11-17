import 'package:boiwalaa/model/user.dart';

class ReviewModel {
  final UserModel user;
  final String? reviewBody;
  final double rating;

  ReviewModel({
    required this.user,
    this.reviewBody,
    required this.rating,
  });
}
