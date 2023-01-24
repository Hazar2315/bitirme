class RealEstatesFilter {
  String? rentSale;
  String? roomNumbers;
  String? realEstateType;
  int? minPrice;
  int? maxPrice;
  int? minBuildAge;
  int? maxBuildAge;
  int? price;
  int? squareMeters;
  int? buildAge;
  int? minSquareMeters;
  int? maxSquareMeters;

  RealEstatesFilter(
      {this.rentSale,
      this.roomNumbers,
      this.realEstateType,
      this.minPrice,
      this.maxPrice,
      this.minBuildAge,
      this.maxBuildAge,
      this.price,
      this.squareMeters,
      this.buildAge,
      this.minSquareMeters,
      this.maxSquareMeters});
  RealEstatesFilter.empty();

  factory RealEstatesFilter.fromJson(Map<String, dynamic> json) {
    return RealEstatesFilter(
      rentSale: json["rentSale"],
      roomNumbers: json["roomNumbers"],
      realEstateType: json["realEstateType"],
      minPrice: json["minPrice"],
      maxPrice: json["maxPrice"],
      minBuildAge: json["minBuildAge"],
      maxBuildAge: json["maxBuildAge"],
      price: json["price"],
      squareMeters: json["squareMeters"],
      buildAge: json["buildAge"],
      minSquareMeters: json["minSquareMeters"],
      maxSquareMeters: json["maxSquareMeters"],
    );
  }
}
