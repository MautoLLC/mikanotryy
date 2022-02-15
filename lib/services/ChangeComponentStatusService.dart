import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mymikano_app/services/DioClass.dart';
import 'package:mymikano_app/utils/appsettings.dart';

late Dio dio;

Future<void> PrepareCall() async {
  dio = await DioClass.getDio();
}

changeChecklistItemStatus(int? itemId, int? StatusId) async {
  try {
    final queryParameters = {
      inspectionChecklistItemIDParameter: itemId.toString(),
      componentStatusIDParameter: StatusId.toString(),
    };
    final url = Uri.http("dev.codepickles.com:8087",
        ChangeStatusCustomCheckListURL, queryParameters);
    print(url);
    await PrepareCall();
    final response = await dio.put(url.toString());
    print(response.data);
    // print(url);
    print(response.statusCode);
    if (response.statusCode == 204) {
      print("Component status updated!");
      Fluttertoast.showToast(
          msg: "Component status updated!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black87,
          fontSize: 16.0);
    } else {
      print("Failed to update component status!" + response.data.toString());
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
    print(e);
    print("Failed to update component status!" + e.toString());
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
