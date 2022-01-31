import 'ProductModel.dart';

class CartProduct{
  late Product product;
  late int quantity;
  int? id;
  CartProduct({required this.product, required this.quantity, this.id});

  CartProduct.fromJson(Map<String, dynamic> json) {
    product = (json['product'] != null ? new Product.fromJson(json['product']) : null)!;
    quantity = json['quantity'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['quantity'] = this.quantity;
    data['id'] = this.id;
    return data;
  }
}