import 'dart:convert';

class RealEstatesFilter {
  String? kiralikSatilik;
  String? odaSayisi;
  String? realEstateType;
  int? minFiyat;
  int? maxFiyat;
  int? minBinaYasi;
  int? maxBinaYasi;
  int? fiyat;
  int? metrekare;
  int? binaYasi;
  int? minMetrekare;
  int? maxMetrekare;

  RealEstatesFilter(
      {this.kiralikSatilik,
      this.odaSayisi,
      this.realEstateType,
      this.minFiyat,
      this.maxFiyat,
      this.minBinaYasi,
      this.maxBinaYasi,
      this.fiyat,
      this.metrekare,
      this.binaYasi,
      this.minMetrekare,
      this.maxMetrekare});
  RealEstatesFilter.empty();

  factory RealEstatesFilter.fromJson(Map<String, dynamic> json) {
    return RealEstatesFilter(
      kiralikSatilik: json["kiralikSatilik"],
      odaSayisi: json["odaSayisi"],
      realEstateType: json["realEstateType"],
      minFiyat: json["minFiyat"],
      maxFiyat: json["maxFiyat"],
      minBinaYasi: json["minBinaYasi"],
      maxBinaYasi: json["maxBinaYasi"],
      fiyat: json["fiyat"],
      metrekare: json["metrekare"],
      binaYasi: json["binaYasi"],
      minMetrekare: json["minMetrekare"],
      maxMetrekare: json["maxMetrekare"],
    );
  }
}
