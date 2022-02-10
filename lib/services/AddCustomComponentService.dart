import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mymikano_app/services/DioClass.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mymikano_app/models/ComponentModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

late Dio dio;

Future<void> PrepareCall() async {
  dio = await DioClass.getDio();
}

AddCustomComponentService(ComponentModel comp, int idInspection) async {
  try {
    final url =
        ("$PostInspectionCustomChecklistItemURL${idInspection.toString()}");
    print(url);
    await PrepareCall();
    print(
        "comp.componentDescription.toString() ====>>>> ${comp.componentDescription.toString()}");
    var response = await dio.post((url), data: {
      "customComponentName": comp.componentName.toString(),
      "customComponentDescription": comp.componentDescription.toString(),
      "customComponentProvider": comp.componentProvider.toString(),
      "customComponentUnitPrice": comp.componentUnitPrice
    });
    if (response.statusCode == 200) {
      print("Component created!");
      Fluttertoast.showToast(
          msg: "Component created! ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: t13_edit_text_color,
          textColor: Colors.black87,
          fontSize: 16.0);
    } else {
      print("Failed to create component !" + response.data.toString());
      Fluttertoast.showToast(
          msg: "Error in  creating component ! ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: t13_edit_text_color,
          textColor: Colors.black87,
          fontSize: 16.0);
    }
  } on Exception catch (e) {
    print(e);
    print("Failed to create component !" + e.toString());
    Fluttertoast.showToast(
        msg: "Error in  creating component ! ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: t13_edit_text_color,
        textColor: Colors.black87,
        fontSize: 16.0);
  }
}
