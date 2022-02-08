

class HtmlPage {
  HtmlPage({
    this.id,
    this.views,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.title,
    this.description,
    this.keyWords,
    this.slug,
    this.translations,
    this.pageId,
    this.locale,
  });

  int? id;
  int? views;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? title;
  String? description;
  dynamic keyWords;
  String? slug;
  List<HtmlPage>? translations;
  int? pageId;
  String? locale;

  factory HtmlPage.fromJson(Map<String, dynamic> json) => HtmlPage(
    id: json["id"],
    views: json["views"] == null ? null : json["views"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    title: json["title"],
    description: json["description"],
    keyWords: json["key_words"],
    slug: json["slug"],
    translations: json["translations"] == null ? null : List<HtmlPage>.from(json["translations"].map((x) => HtmlPage.fromJson(x))),
    pageId: json["page_id"] == null ? null : json["page_id"],
    locale: json["locale"] == null ? null : json["locale"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "views": views == null ? null : views,
    "deleted_at": deletedAt,
    "title": title,
    "description": description,
    "key_words": keyWords,
    "slug": slug,
    "page_id": pageId == null ? null : pageId,
    "locale": locale == null ? null : locale,
  };
}
