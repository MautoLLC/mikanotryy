import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mymikano_app/models/RealEstateModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mymikano_app/services/DioClass.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class RealEstatesService {
  late Dio dio;

  Future<void> PrepareCall() async {
    dio = await DioClass.getDio();
  }

  Future<List<RealEstate>> fetchRealEstatesService() async {
    await PrepareCall();
    final response = await dio.get((GetRealEstatesURL));

    if (response.statusCode == 200) {
      List<RealEstate> listresult = [];
      for (var item in response.data) {
        listresult.add(RealEstate.fromJson(item));
      }
      return listresult;
    } else
      throw Exception('Error fetching');
  }
}
