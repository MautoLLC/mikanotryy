import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mymikano_app/models/ComponentModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

AddCustomComponentService(ComponentModel comp, int idInspection) async {

  try {
    var client = await oauth2.clientCredentialsGrant(
        Uri.parse(authorizationEndpoint), identifier, secret);

    final url = Uri.parse(
        PostInspectionCustomChecklistItemURL + idInspection.toString());


    final body = {
      "customComponentName": comp.componentName.toString(),
      "customComponentDescription": comp.componentDescription.toString(),
      "customComponentProvider": comp.componentProvider.toString(),
      "customComponentUnitPrice": comp.componentUnitPrice
    };

    var response =
    await client.post(url, body: json.encode(body),
        headers: {'Content-type': 'application/json',});

    if (response.statusCode == 200)
    {
      print("Component created!");
      Fluttertoast.showToast(
          msg: "Component created! " ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: t13_edit_text_color ,
          textColor: Colors.black87,
          fontSize: 16.0
      );
    }
    else{
      print("Failed to create component !"+ response.body.toString());
      Fluttertoast.showToast(
          msg: "Error in  creating component ! " ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: t13_edit_text_color ,
          textColor: Colors.black87,
          fontSize: 16.0
      );


    }
  }

  on Exception catch (e) {
    print(e);
    print("Failed to create component !"+ e.toString());
    Fluttertoast.showToast(
        msg: "Error in  creating component ! " ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: t13_edit_text_color ,
        textColor: Colors.black87,
        fontSize: 16.0
    );
  }

}
