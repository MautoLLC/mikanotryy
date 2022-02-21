import 'package:dio/dio.dart';
import 'package:mymikano_app/models/ComponentModel.dart';
import 'package:mymikano_app/services/DioClass.dart';
import 'package:mymikano_app/models/InspectionChecklistItem.dart';
import 'package:mymikano_app/models/PredefinedChecklistModel.dart';
import 'dart:convert';
import 'package:mymikano_app/utils/appsettings.dart';

class ChecklistItemsService {
  late Dio dio;

  Future<void> PrepareCall() async {
    dio = await DioClass.getDio();
  }

  Future<List<PredefinedChecklistModel>> fetchItems(int idMainCat) async {
    final url = (GetPredefinedCheckListByCategURL + idMainCat.toString());

    await PrepareCall();
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.data) as List<dynamic>;
      final listresult =
          json.map((e) => PredefinedChecklistModel.fromJson(e)).toList();

      return listresult;
    } else {
      throw Exception('Error fetching');
    }
  }

  Future<List<InspectionChecklistItem>> fetchItemsById(int inspId) async {
    final url = (GetCustomCheckListByInspectionURL + inspId.toString());

    await PrepareCall();
    dynamic response = await dio.get(url);
    // print(response.data);

    if (response.statusCode == 200) {
      List<InspectionChecklistItem> listresult = [];

      for (var item in response.data) {
        InspectionChecklistItem temp = InspectionChecklistItem.fromJson(item);

        listresult.add(temp);
      }
      return listresult;
    } else {
      throw Exception('Error fetching');
    }
  }

  Future<List<dynamic>> fetchPredefinedComponents(int inspId) async{
    final url = (GetPredefinedComponentsURL.replaceAll("{inspectionID}", inspId.toString()));

    await PrepareCall();
    dynamic response = await dio.get(url);

    if (response.statusCode == 200) {
      List<dynamic> listresult = [];

      for (var item in response.data) {
        listresult.add(ComponentModel.fromJson(item));
      }
      return listresult;
    } else {
      throw Exception('Error fetching');
    }
  }
  Future<List<dynamic>> fetchCustomComponents(int inspId) async{
    final url = (GetCustomComponentsURL.replaceAll("{inspectionID}", inspId.toString()));

    await PrepareCall();
    dynamic response = await dio.get(url);

    if (response.statusCode == 200) {
      List<dynamic> listresult = [];

      for (var item in response.data) {
        print(item.toString());
        ComponentModel model = ComponentModel.fromJson(item['customComponent']);
        model.status = item['componentStatus']['componentStatusDescription'];
        listresult.add(model);
      }
      return listresult;
    } else {
      throw Exception('Error fetching');
    }
  }
}
