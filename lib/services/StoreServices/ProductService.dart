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
    Response response2 = await dio.get(MikanoShopGetLoggedInUser,
        options: Options(headers: {
          "Authorization": "Bearer ${prefs.getString("StoreToken")}"
        }));
    if (response.statusCode == 200 && response2.statusCode == 200) {
      // List<Product> favoriteProducts = [];

      // for (var item in response.data['customers'][0]['FavoriteProducts']) {
      //   favoriteProducts.add(Product.fromJson(item));
      // }
      List<Product> products = [];
      try {
        for (var item in response.data['products']) {
          Product temp = Product.fromJson(item);
          // if(favoriteProducts.contains(temp))
          //   temp.liked = true;
          products.add(temp);
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

  Future<void> addProductToFavorite(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response response = await dio.get(
        MikanoAddProductToFavorites.replaceAll("{id}", id.toString()),
        options: Options(headers: {
          "Authorization": "Bearer ${prefs.getString("StoreToken")}"
        }));
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to add product to favorite');
    }
  }

  Future<void> removeProductToFavorite(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response response = await dio.get(
        MikanoRemoveProductFromFavorites.replaceAll("{id}", id.toString()),
        options: Options(headers: {
          "Authorization": "Bearer ${prefs.getString("StoreToken")}"
        }));
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to add product to favorite');
    }
  }
}
