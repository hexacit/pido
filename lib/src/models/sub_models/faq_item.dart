

class FaqItem {
  FaqItem({
    this.id,
    this.status,
    this.createdAt,
    this.question,
    this.answer,
  });

  int? id;
  String? status;
  DateTime? createdAt;
  String? question;
  String? answer;

  factory FaqItem.fromJson(Map<String, dynamic> json) => FaqItem(
    id: json["id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    question: json["question"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "question": question,
    "answer": answer,
  };
}
