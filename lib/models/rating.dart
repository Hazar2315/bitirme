import 'package:hazar_emlak/models/real_estates.dart';
import 'package:hazar_emlak/models/user.dart';

class Ratings {
  int? user_id;
  int? realEstates_id;
  String? comment;
  double? ratings;
  RealEstates? realEstates;
  Users2? user;

  Ratings(
      {this.realEstates_id,
      this.user_id,
      this.comment,
      this.ratings,
      this.realEstates,
      this.user});

  factory Ratings.fromJson(Map<dynamic, dynamic> json) {
    return Ratings(
        user_id: json["user_id"],
        realEstates_id: json["realEstates_id"],
        comment: json['comments'],
        ratings: json['ratings'],
        realEstates: RealEstates.fromJson(json["realEstates"]),
        user: Users2.fromJson(json["user"]));
  }
}
