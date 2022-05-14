import 'package:dio/dio.dart';
import 'package:mymikano_app/models/CarouselImageModel.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductsService {
  Dio dio = new Dio();
  Future<List<Product>> getProducts({int limit = -1, int page = -1}) async {
    Map<String, dynamic> params = {};
    if (limit != -1) {
      params["limit"] = limit;
    }
    if (page != -1) {
      params["page"] = page;
    }
    params['Fields'] = "full_description, name, id, price, images, sku, Category, approved_rating_sum";
    Response response = await dio.get(MikanoShopGetAllProductsURL,
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
        print(e);
        return products;
      }
    } else {
      throw Exception('Failed to load products');
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
      print(e);
      return [];
    }
  }
}
