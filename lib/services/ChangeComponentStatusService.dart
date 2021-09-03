import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

var headers;

void PrepareHeader() async {
  Directory directory = await getApplicationDocumentsDirectory();
  File file = File('${directory.path}/credentials.json');
  String fileContent = await file.readAsString();
  headers = {
    "Accept": "application/json",
    'Authorization': 'Bearer $fileContent'
  };
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
    PrepareHeader();
    final response = await http.post(url, headers: headers);
    print(response.body);
    // print(url);
    //  print(response.statusCode);
    if (response.statusCode == 204) {
      print("Component status updated!");
      Fluttertoast.showToast(
          msg: "Component status updated!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: t13_edit_text_color,
          textColor: Colors.black87,
          fontSize: 16.0);
    } else {
      print("Failed to update component status!" + response.body.toString());
      Fluttertoast.showToast(
          msg: "Failed to update component status!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: t13_edit_text_color,
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
        backgroundColor: t13_edit_text_color,
        textColor: Colors.black87,
        fontSize: 16.0);
  }
}
