import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mymikano_app/models/ComponentModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
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

AddCustomComponentService(ComponentModel comp, int idInspection) async {
  try {
    final url = Uri.parse(
        PostInspectionCustomChecklistItemURL + idInspection.toString());

    final body = {
      "customComponentName": comp.componentName.toString(),
      "customComponentDescription": comp.componentDescription.toString(),
      "customComponentProvider": comp.componentProvider.toString(),
      "customComponentUnitPrice": comp.componentUnitPrice
    };

    var response =
        await http.post(url, body: json.encode(body), headers: headers);

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
      print("Failed to create component !" + response.body.toString());
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
