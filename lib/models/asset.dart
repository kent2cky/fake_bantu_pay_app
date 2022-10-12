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

  toJSONEncodable() {
    Map<String, dynamic> m = Map();

    m['id'] = id;
    m['name'] = name;
    m['fullName'] = fullName;
    m['description'] = description;
    m['issuer'] = issuer;
    m['logo'] = logo;
    m['availableBalance'] = availableBalance;
    m['nairaValue'] = nairaValue;
    m['nairaExchangeRate'] = nairaExchangeRate;
    m['transferQnty'] = transferQnty;

    return m;
  }

  deserializeJSON(Map<String, dynamic> m) {
    return Asset(
      id: m['id'],
      name: m['name'],
      fullName: m['fullName'],
      description: m['description'],
      issuer: m['issuer'],
      logo: m['logo'],
      availableBalance: m['availableBalance'],
      nairaValue: m['nairaValue'],
      nairaExchangeRate: m['nairaExchangeRate'],
      transferQnty: m['transferQnty'],
    );
  }
}
