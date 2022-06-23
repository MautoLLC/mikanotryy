import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mymikano_app/models/ComponentModel.dart';
import 'package:mymikano_app/services/DioClass.dart';
import 'package:mymikano_app/models/ComponentStatusModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';

class ComponentService {
  late Dio dio;

  Future<void> PrepareCall() async {
    dio = await DioClass.getDio();
  }

  Future<List<ComponentStatus>> fetchComponentStatus() async {
    final url = (ComponentsStatusURL);
    await PrepareCall();
    final response = await dio.get(url);
    debugPrint(url);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      List<ComponentStatus> listresult = [];
      for (var item in response.data) {
        listresult.add(ComponentStatus.fromJson(item));
      }
      return listresult;
    } else
      throw Exception('Error fetching');
  }

  changeChecklistItemStatus(int? itemId, int? StatusId) async {
    try {
      final queryParameters = {
        inspectionChecklistItemIDParameter: itemId.toString(),
        componentStatusIDParameter: StatusId.toString(),
      };
      final url = Uri.http("dev.codepickles.com:8087",
          ChangeStatusCustomCheckListURL, queryParameters);
      debugPrint(url.toString());
      await PrepareCall();
      final response = await dio.put(url.toString());
      debugPrint(response.data);
      // debugPrint(url);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 204) {
        debugPrint("Component status updated!");
        Fluttertoast.showToast(
            msg: "Component status updated!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black87,
            fontSize: 16.0);
      } else {
        debugPrint(
            "Failed to update component status!" + response.data.toString());
        Fluttertoast.showToast(
            msg: "Failed to update component status!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black87,
            fontSize: 16.0);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      debugPrint("Failed to update component status!" + e.toString());
      Fluttertoast.showToast(
          msg: "Failed to update component status! ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black87,
          fontSize: 16.0);
    }
  }

  Future<bool> AddCustomComponentService(
      ComponentModel comp, int idInspection) async {
    try {
      final url =
          ("$PostInspectionCustomChecklistItemURL${idInspection.toString()}");
      debugPrint(url);
      await PrepareCall();
      var response = await dio.post((url), data: {
        "customComponentName": comp.componentName.toString(),
        "customComponentDescription": comp.componentDescription.toString(),
        "customComponentProvider": comp.componentProvider.toString(),
        "customComponentUnitPrice": comp.componentUnitPrice
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      return false;
    }
  }

  Future<bool> deleteComponent(int id) async {
    try {
      final url = (DeleteInspectionCustomChecklistItemURL.replaceAll(
          "{id}", id.toString()));
      await PrepareCall();
      debugPrint(url);
      var response = await dio.delete(url);
      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
