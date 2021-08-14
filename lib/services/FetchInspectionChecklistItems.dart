import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mymikano_app/models/InspectionChecklistItem.dart';
import 'package:mymikano_app/models/PredefinedChecklistModel.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'dart:convert';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:mymikano_app/utils/appsettings.dart';
class ChecklistItemsService{

  Future<List<PredefinedChecklistModel>> fetchItems(int idMainCat) async{

    var client = await oauth2.clientCredentialsGrant(Uri.parse(authorizationEndpoint), identifier, secret);

    final url = Uri.parse(GetPredefinedCheckListByCategURL+idMainCat.toString());

    final response = await client.get(url);

    if (response.statusCode == 200)
    {
      final json= jsonDecode(response.body) as List<dynamic>;
      final listresult=json.map((e) => PredefinedChecklistModel.fromJson(e)).toList();

      return listresult;

    }
    else
    {
      throw Exception('Error fetching');}
  }
 // GetCustomCheckListByInspectionURL

  Future<List<InspectionChecklistItem>> fetchAllItems(int inspId) async{

    var client = await oauth2.clientCredentialsGrant(Uri.parse(authorizationEndpoint), identifier, secret);

    final url = Uri.parse(GetCustomCheckListByInspectionURL+inspId.toString());

    final response = await client.get(url);

    if (response.statusCode == 200)
    {
      final json= jsonDecode(response.body) as List<dynamic>;
      final listresult=json.map((e) => InspectionChecklistItem.fromJson(e)).toList();

      return listresult;

    }
    else
    {
      throw Exception('Error fetching');}
  }


}