class Zone {
  Zone({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}