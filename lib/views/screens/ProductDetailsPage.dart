import 'package:flutter/material.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductDetailsPage extends StatelessWidget {
  Product product;
  ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IconButton(
        onPressed: () => finish(context),
        icon: Icon(Icons.arrow_back_ios_new),
      ),
    );
  }
}
