import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mymikano_app/models/InspectionChecklistItem.dart';
import 'package:mymikano_app/models/PredefinedChecklistModel.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:path_provider/path_provider.dart';

class ChecklistItemsService {
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

  Future<List<PredefinedChecklistModel>> fetchItems(int idMainCat) async {
    final url =
        Uri.parse(GetPredefinedCheckListByCategURL + idMainCat.toString());

    PrepareHeader();
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      final listresult =
          json.map((e) => PredefinedChecklistModel.fromJson(e)).toList();

      return listresult;
    } else {
      throw Exception('Error fetching');
    }
  }

  Future<List<InspectionChecklistItem>> fetchAllItems(int inspId) async {
    final url =
        Uri.parse(GetCustomCheckListByInspectionURL + inspId.toString());

    PrepareHeader();
    final response = await http.get(url, headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      final listresult =
          json.map((e) => InspectionChecklistItem.fromJson(e)).toList();

      return listresult;
    } else {
      throw Exception('Error fetching');
    }
  }
}
