
import 'package:pido/src/models/sub_models/product.dart';

class CategoryProducts {
  CategoryProducts({

    this.items,
    this.isMore,
  });


  List<Product>? items;
  bool? isMore;

  factory CategoryProducts.fromJson(Map<String, dynamic> json) => CategoryProducts(

    items: List<Product>.from(json["items"].map((x) => Product.fromJson(x))),
    isMore: json["is_more"],
  );

  Map<String, dynamic> toJson() => {

    "is_more": isMore,
  };
}
