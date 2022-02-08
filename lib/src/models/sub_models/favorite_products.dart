import 'package:pido/src/models/sub_models/product.dart';
import 'package:pido/src/models/sub_models/user_favorite_data.dart';

class FavoriteProducts {
  FavoriteProducts({

    this.results,
    this.isMore,
  });


  List<FavoriteItem>? results;
  bool? isMore;

  factory FavoriteProducts.fromJson(Map<String, dynamic> json) => FavoriteProducts(

    results: List<FavoriteItem>.from(json["items"].map((x) => FavoriteItem.fromJson(x))),
    isMore: json["is_more"],
  );


}
