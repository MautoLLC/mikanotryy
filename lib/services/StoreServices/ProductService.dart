import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/models/CarouselImageModel.dart';
import 'package:mymikano_app/models/StoreModels/ProductCategory.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductsService {
  Dio dio = new Dio();

  String Params =
      "full_description, name, id, price, images, sku, Category, approved_rating_sum, is_top_deal, display_order, call_for_price";
  Future<List<Product>> getProducts(
      {int limit = -1, int page = -1, int categoryID = -1, String searchTerm = '', List<int> ids = const []}) async {
    Map<String, dynamic> params = {};
    if(ids.isNotEmpty){
      params["ids"] = ids;
    }
    if (limit != -1) {
      params["limit"] = limit;
    }
    if (page != -1) {
      params["page"] = page;
    }
    if (categoryID != -1) {
      params["CategoryId"] = categoryID;
    }
    if(searchTerm != ''){
      params["Name"] = searchTerm;
    }
    params['Fields'] = Params;
    params['PublishedStatus'] = true;
    Response response = await dio.get(
      MikanoShopGetAllProductsURL,
      queryParameters: params,
    );
    if (response.statusCode == 200) {
      List<Product> products = [];
      try {
        for (var item in response.data['products']) {
          Product temp = Product.fromJson(item);
          products.add(temp);
        }
        return products;
      } catch (e) {
        debugPrint(e.toString());
        return products;
      }
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> getTopDealsProducts(
      {int limit = -1, int page = -1}) async {
    Map<String, dynamic> params = {};
    if (limit != -1) {
      params["limit"] = limit;
    }
    if (page != -1) {
      params["page"] = page;
    }
    params['Fields'] = Params;
    params['PublishedStatus'] = true;
    Response response = await dio.get(
      MikanoShopGetTopDealsProductsURL,
      queryParameters: params,
    );
    if (response.statusCode == 200) {
      List<Product> products = [];
      try {
        for (var item in response.data['products']) {
          Product temp = Product.fromJson(item);
          products.add(temp);
        }
        return products;
      } catch (e) {
        debugPrint(e.toString());
        return products;
      }
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> getFeaturedProducts(
      {int limit = -1, int page = -1}) async {
    Map<String, dynamic> params = {};
    if (limit != -1) {
      params["limit"] = limit;
    }
    if (page != -1) {
      params["page"] = page;
    }
    params['Fields'] = Params;
    params['PublishedStatus'] = true;
    Response response = await dio.get(
      MikanoShopGetFeaturedProductsURL,
      queryParameters: params,
    );
    if (response.statusCode == 200) {
      List<Product> products = [];
      try {
        for (var item in response.data['products']) {
          Product temp = Product.fromJson(item);
          products.add(temp);
        }
        return products;
      } catch (e) {
        debugPrint(e.toString());
        return products;
      }
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<ProductCategory>> getCategories(
      {int limit = -1, int page = -1, int parentId = -1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> params = {};
    if (limit != -1) {
      params["limit"] = limit;
    }
    if (page != -1) {
      params["page"] = page;
    }
    if (parentId != -1) {
      params["ParentCategoryId"] = parentId;
    }
    // params["Fields"] = "name, parent_category_id, id, image";
    Response response = await dio.get(MikanoShopCategoriesURL,
        queryParameters: params,
        options: Options(headers: {
          'Authorization': 'Bearer ${prefs.getString("StoreToken")}',
        }));
    if (response.statusCode == 200) {
      List<ProductCategory> products = [];
      try {
        for (var item in response.data['categories']) {
          ProductCategory temp = ProductCategory.fromJson(item);
          products.add(temp);
        }
        return products;
      } catch (e) {
        debugPrint(e.toString());
        return products;
      }
    } else {
      throw Exception('Failed to load Categories');
    }
  }

  Future<List<CarouselImageModel>> getCarouselImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Response response = await dio.get(MikanoCarouselImagesUrl,
          options: Options(headers: {
            "Authorization": "Bearer ${prefs.getString("accessToken")}"
          }));
      if (response.statusCode == 200) {
        List<CarouselImageModel> images = [];
        for (var item in response.data) {
          CarouselImageModel image = CarouselImageModel.fromJson(item);
          images.add(image);
        }
        return images;
      } else {
        throw Exception('Failed to load Carousel Items');
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

    Future<List<Product>> getRelatedProducts(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Response response = await dio.get(MikanoShopGetRelatedProductsById.replaceAll('{Id}', id.toString()),
          options: Options(headers: {
            'Authorization': 'Bearer ${prefs.getString("StoreToken")}',
          }));
      if (response.statusCode == 200) {
        List<Product> products = [];
        for (var item in response.data['products']) {
          Product product = Product.fromJson(item);
          products.add(product);
        }
        return products;
      } else {
        throw Exception('Failed to load Related Products');
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
