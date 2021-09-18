import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DioClass.dart';

class MaintenanceRequestService {
  late Dio dio;

  Future<void> PrepareCall() async {
    dio = await DioClass.getDio();
  }

  Future<List<MaintenanceRequestModel>> fetchAllMaintenanceRequest() async {
    await PrepareCall();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response;
    List<MaintenanceRequestModel> listresult = [];
    try {
      response = await dio.get((GetMaintenaceRequestURL));
      if (response.statusCode == 200) {
        for (var item in response.data) {
          listresult.add(MaintenanceRequestModel.fromJson(item));
        }
      } else {
        print((GetMaintenaceRequestURL).toString());
        print(response.body.toString());
        throw Exception('Error fetching');
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return listresult;
  }

  Future<List<MaintenanceRequestModel>> fetchMaintenanceRequest() async {
    await PrepareCall();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response;
    List<MaintenanceRequestModel> listresult = [];

    try {
      response = await dio.get((GetMaintenaceRequestURL +
          '/UserRequests/' +
          prefs.getString('UserID').toString()));

      if (response.statusCode == 200) {
        for (var item in response.data) {
          listresult.add(MaintenanceRequestModel.fromJson(item));
        }
      } else {
        print((GetMaintenaceRequestURL).toString());
        throw Exception('Error fetching');
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return listresult;
  }

  Future<MaintenanceRequestModel> fetchMaintenanceRequestByID(int id) async {
    await PrepareCall();
    final response = await dio.get((GetMaintenaceRequestURL + '/$id'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return MaintenanceRequestModel.fromJson(response.data);
    } else {
      print(response.data.toString());
      throw Exception('Error fetching');
    }
  }
}
