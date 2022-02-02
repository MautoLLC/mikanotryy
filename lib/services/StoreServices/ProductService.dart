import 'package:dio/dio.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductsService {
  Dio dio = new Dio();
  Future<List<Product>> getProducts({int limit = -1, int page = -1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> params = {};
    if(limit!=-1){
      params["limit"] = limit;
    }
    if(page!=-1){
      params["page"] = page;
    }
    Response response = await dio.get(MikanoShopGetAllProductsURL,
    queryParameters: params,
        options: Options(headers: {
          "Authorization": "Bearer ${prefs.getString("StoreToken")}"
        }));
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
}
