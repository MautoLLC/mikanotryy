import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductsService {
  Dio dio = new Dio();
  Future<List<Product>> getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response response = await dio.get(MikanoShopGetAllProductsURL,
        options: Options(headers: {
          "Authorization": "Bearer ${prefs.getString("StoreToken")}"
        }));
    if (response.statusCode == 200) {
      List<Product> products = [];
      try {
        // products = response.data['products'].map((e) => Product.fromJson(e)).toList();
        for (var item in response.data['products']) {
          products.add(Product.fromJson(item));
        }
        return products;
      } catch (e) {
        print(e);
        return products;
      }
    } else {
      throw Exception('Failed to load products');
    }
  }
}
