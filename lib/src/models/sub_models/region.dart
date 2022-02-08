class Region {
  Region({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}