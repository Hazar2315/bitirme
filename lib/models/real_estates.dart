import 'package:hazar_emlak/models/rating.dart';

class RealEstates {
  int? id;
  String? headerText;
  String? bodyText;
  String? rentSale;
  int? price;
  int? squareMeters;
  String? roomNumbers;
  int? buildAge;
  String? realEstateType;
  Ratings? rating = Ratings(ratings: 0);
  String? sellerPhone;
  String? sellersCompany;
  RealEstates(
      {this.id,
      this.headerText,
      this.bodyText,
      this.rentSale,
      this.price,
      this.squareMeters,
      this.roomNumbers,
      this.buildAge,
      this.realEstateType,
      this.sellerPhone,
      this.sellersCompany});
  RealEstates.empty();

  @override
  toString() =>
      "RealState(price : ${price.toString()} ; buildAge: ${buildAge.toString()} ; squareMeters: ${squareMeters.toString()} )";

  factory RealEstates.fromJson(Map<String, dynamic> json) {
    return RealEstates(
        id: json["id"],
        headerText: json["headerText"],
        bodyText: json["bodyText"],
        rentSale: json["rentSale"],
        price: json["price"],
        squareMeters: json["squareMeters"],
        roomNumbers: json["roomNumbers"],
        buildAge: json["buildAge"],
        realEstateType: json["realEstateType"],
        sellerPhone: json["sellerPhone"],
        sellersCompany: json["sellersCompany"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["headerText"] = headerText;
    data["bodyText"] = bodyText;
    data["rentSale"] = rentSale;
    data["price"] = price;
    data["squareMeters"] = squareMeters;
    data["roomNumbers"] = roomNumbers;
    data["buildAge"] = buildAge;
    data["realEstateType"] = realEstateType;
    data["sellerPhone"] = sellerPhone;
    data["sellersCompany"] = sellersCompany;
    return data;
  }
}
