import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mymikano_app/models/LoadCalculationModels/EquipmentModel.dart';
import 'package:mymikano_app/models/StoreModels/ProductCategory.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/LoadCalculationModels/KVAResponse.dart';
import 'DioClass.dart';

class LoadCalculationService {
  late Dio dio;

  Future<void> PrepareCall() async {
    dio = await DioClass.getDio();
  }

  Future<List<Equipment>> fetchAllEquipments() async {
    await PrepareCall();

    Response response;
    List<Equipment> listresult = [];

    try {
      response = await dio.get(MikanoLoadCalculationEquipments);
      if (response.statusCode == 200) {
        for (var item in response.data) {
          listresult.add(Equipment.fromJson(item));
        }
        return listresult;
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception();
    }
    return listresult;
  }

  Future<List<ProductCategory>> fetchGeneratorsResult(double kva) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response response;
    List<ProductCategory> listresult = [];

    try {
      response = await Dio()
          .get(MikanoShopCategoriesKva.replaceAll("{kva}", kva.toString()),
              options: Options(headers: {
                'Authorization': 'Bearer ${prefs.getString("StoreToken")}',
              }));
      if (response.statusCode == 200) {
        for (var item in response.data['categories']) {
          listresult.add(ProductCategory.fromJson(item));
        }
        return listresult;
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception();
    }
    return listresult;
  }

  Future<KVAResponse> CalculateKVA(int utils, List<int> Ids) async {
    Response response;
    KVAResponse result;
    try {
      response = await Dio().post(
          MikanoLoadCalculationCalculateKVA.replaceAll(
              "{utils}", utils.toString()),
          data: Ids);
      if (response.statusCode == 200) {
        result = KVAResponse.fromJson(response.data);
        return result;
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception();
    }
    throw Exception();
  }
}
