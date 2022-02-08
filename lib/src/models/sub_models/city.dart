class City {
  City({
    this.id,
    this.deliveryCost,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.translations,
  });

  int? id;
  int? deliveryCost;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? name;
  List<Translation>? translations;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        deliveryCost: json["deliveryCost"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        name: json["name"],
        translations: List<Translation>.from(
            json["translations"].map((x) => Translation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deliveryCost": deliveryCost,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
        "name": name,
        "translations": List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class Translation {
  Translation({
    this.id,
    this.cityId,
    this.locale,
    this.name,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? cityId;
  String? locale;
  String? name;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        id: json["id"],
        cityId: json["city_id"],
        locale: json["locale"],
        name: json["name"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_id": cityId,
        "locale": locale,
        "name": name,
        "deleted_at": deletedAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
