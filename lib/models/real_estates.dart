import 'dart:convert';

class RealEstates {
  int? id;
  String? headerText;
  String? bodyText;
  String? kiralikSatilik;
  int? fiyat;
  int? metrekare;
  String? odaSayisi;
  int? binaYasi;
  String? realEstateType;

  RealEstates(
      {this.id,
      this.headerText,
      this.bodyText,
      this.kiralikSatilik,
      this.fiyat,
      this.metrekare,
      this.odaSayisi,
      this.binaYasi,
      this.realEstateType});
  RealEstates.empty();

  @override
  toString() =>
      "RealState(fiyat : ${fiyat.toString()} ; binaYasi: ${binaYasi.toString()} ; metrekare: ${metrekare.toString()} )";

  factory RealEstates.fromJson(Map<String, dynamic> json) {
    return RealEstates(
      id: json["id"],
      headerText: json["headerText"],
      bodyText: json["bodyText"],
      kiralikSatilik: json["kiralikSatilik"],
      fiyat: json["fiyat"],
      metrekare: json["metrekare"],
      odaSayisi: json["odaSayisi"],
      binaYasi: json["binaYasi"],
      realEstateType: json["realEstateType"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["headerText"] = headerText;
    data["bodyText"] = bodyText;
    data["kiralikSatilik"] = kiralikSatilik;
    data["fiyat"] = fiyat;
    data["metrekare"] = metrekare;
    data["odaSayisi"] = odaSayisi;
    data["binaYasi"] = binaYasi;
    data["realEstateType"] = realEstateType;
    return data;
  }
}
