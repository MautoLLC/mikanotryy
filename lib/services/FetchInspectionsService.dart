import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mymikano_app/models/InspectionModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mymikano_app/services/DioClass.dart';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InspectionService {
  late Dio dio;

  Future<void> PrepareCall() async {
    dio = await DioClass.getDio();
  }

  Future<List<InspectionModel>> fetchInspections() async {
    await PrepareCall();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(GetTechnicianInspectionURL + prefs.getString('UserID').toString());
    final response = await dio.get(
        (GetTechnicianInspectionURL + prefs.getString('UserID').toString()));

    if (response.statusCode == 200) {
      List<InspectionModel> listresult = [];
      for (var item in response.data) {
        listresult.add(InspectionModel.fromJson(item));
      }
      return listresult;
    } else {
      print((GetInspectionURL).toString());
      print(response.data.toString());
      throw Exception('Error fetching');
    }
  }

  Future<List<InspectionModel>> fetchTechnicianInspections(
      int idTechnician) async {
    await PrepareCall();
    final response =
        await dio.get((GetTechnicianInspectionURL + idTechnician.toString()));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.data) as List<dynamic>;
      final listresult = json.map((e) => InspectionModel.fromJson(e)).toList();

      return listresult;
    } else {
      print((GetInspectionURL).toString());
      print(response.data.toString());
      throw Exception('Error fetching');
    }
  }

  Future<List<InspectionModel>> fetchInspectionbyId(int id) async {
    await PrepareCall();
    final response = await dio.get((GetInspectionURL + id.toString()));
    List<InspectionModel> listresult = [];
    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          new Map<String, dynamic>.from(json.decode(response.data));
      InspectionModel inspection = InspectionModel.fromJson(data);

      listresult.add(inspection);
      return listresult;
    } else {
      print((GetInspectionURL).toString());
      print(response.data.toString());
      throw Exception('Error fetching');
    }
  }
}
