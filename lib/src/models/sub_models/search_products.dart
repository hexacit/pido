import 'package:pido/src/models/sub_models/product.dart';

class PaginateProducts {
  PaginateProducts({

    this.results,
    this.isMore,
  });


  List<Product>? results;
  bool? isMore;

  factory PaginateProducts.fromJson(Map<String, dynamic> json) => PaginateProducts(

    results: List<Product>.from(json["items"].map((x) => Product.fromJson(x))),
    isMore: json["is_more"],
  );


}
