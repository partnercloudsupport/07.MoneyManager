class Country {
  final String name;
  final String isoCode;
  final String iso3Code;
  final String currency;
  final String symbol;

  Country(
    {this.isoCode, this.iso3Code, this.currency, this.name, this.symbol = ''});

  factory Country.fromMap(Map<String, String> map) =>
    Country(
      name: map['name'],
      isoCode: map['isoCode'],
      iso3Code: map['iso3Code'],
      currency: map['currency'],
      symbol: map['symbol'],
    );
}
