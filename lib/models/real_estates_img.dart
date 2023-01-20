import 'dart:typed_data';

import 'package:hazar_emlak/models/real_estates.dart';
import 'dart:convert';

class RealEstatesIMG {
  int? id;
  String? base64;
  RealEstates? realEstates;

  RealEstatesIMG({this.id, this.base64, this.realEstates});
  RealEstatesIMG.empty();

  factory RealEstatesIMG.fromJson(Map<String, dynamic> json) {
    return RealEstatesIMG(
        id: json["id"],
        base64: json["base64"],
        realEstates: RealEstates.fromJson(json["realEstates"]));
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    //data["base64"] = base64Encode(base64!);
    return data;
  }
}
