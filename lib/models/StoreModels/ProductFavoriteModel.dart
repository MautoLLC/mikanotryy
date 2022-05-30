import 'package:mymikano_app/models/StoreModels/ProductModel.dart';

class FavoriteProduct {
  late Product product;
  late int? id;

  FavoriteProduct({required this.product, this.id});

  FavoriteProduct.fromJson(Map<String, dynamic> json) {
    product = (json['product'] != null
        ? new Product.fromJson(json['product'])
        : null)!;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product.toJson();
    data['id'] = this.id;
    return data;
  }
}
