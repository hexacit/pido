class Area {
  Area({
    this.id,
    this.deliveryCharges,
    this.status,
    this.name,
  });

  int? id;
  int? deliveryCharges;
  String? status;
  String? name;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
    id: json["id"],
    deliveryCharges: json["delivery_charges"],
    status: json["status"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "delivery_charges": deliveryCharges,
    "status": status,
    "name": name,
  };
}
