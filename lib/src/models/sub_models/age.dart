
class Age {
  Age({
    this.id,
    this.name,
    this.status,
    this.createdAt,
  });

  int? id;
  String? name;
  String? status;
  DateTime? createdAt;

  factory Age.fromJson(Map<String, dynamic> json) => Age(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
  };
}
