class Asset {
  int? id;
  String? name;
  String? fullName;
  String? description;
  String? issuer;
  String? logo;
  double? availableBalance;
  double? nairaValue;
  double? nairaExchangeRate;
  double? transferQnty;

  Asset({
    this.id,
    this.name,
    this.fullName,
    this.description,
    this.issuer,
    this.logo,
    this.availableBalance,
    this.nairaValue,
    this.nairaExchangeRate,
    this.transferQnty,
  });
}
