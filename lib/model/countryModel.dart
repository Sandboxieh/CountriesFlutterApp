import 'dart:convert';

List<Country> countryFromJson(String str) =>
    List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

String countryToJson(List<Country> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Country {
  Country({
    this.id,
    this.enabled,
    this.code3L,
    this.code2L,
    this.name,
    this.nameOfficial,
    this.flag,
    this.latitude,
    this.longitude,
    this.zoom,
  });

  dynamic id;
  String enabled;
  String code3L;
  String code2L;
  String name;
  String nameOfficial;
  String flag;
  String latitude;
  String longitude;
  String zoom;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        enabled: json["enabled"],
        code3L: json["code3l"],
        code2L: json["code2l"],
        name: json["name"],
        nameOfficial: json["name_official"],
        flag: json["flag"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        zoom: json["zoom"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "enabled": enabled,
        "code3l": code3L,
        "code2l": code2L,
        "name": name,
        "name_official": nameOfficial,
        "flag": flag,
        "latitude": latitude,
        "longitude": longitude,
        "zoom": zoom,
      };
}
