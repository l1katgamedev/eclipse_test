
class User {
  final dynamic id;
  final dynamic name;
  final dynamic username;
  final dynamic email;
  Address? address;
  final dynamic phone;
  final dynamic website;
  Company? company;

  User({this.id, this.name, this.username, this.email, this.address, this.phone, this.website, this.company});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: Address.fromJson(json["address"]),
      phone: json["phone"],
      website: json["website"],
      company: Company.fromJson(json["company"]),
    );
  }
}

class Address {
  final dynamic street;
  final dynamic suite;
  final dynamic city;
  final dynamic zipcode;
  Geo? geo;

  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
        geo: Geo.fromJson(json["geo"]),
      );
}

class Geo {
  final dynamic lat;
  final dynamic lng;

  Geo({
    this.lat,
    this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
        lat: json["lat"],
        lng: json["lng"],
      );
}

class Company {
  final dynamic name;
  final dynamic catchPhrase;
  final dynamic bs;

  Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json["name"],
        catchPhrase: json["catchPhrase"],
        bs: json["bs"],
      );
}
