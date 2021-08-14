import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:oauth2/oauth2.dart' as oauth2;


changeChecklistItemStatus(int itemId,int StatusId) async {

  try {
    var client = await oauth2.clientCredentialsGrant(
        Uri.parse(authorizationEndpoint), identifier, secret);

    // final url = Uri.parse(ChangeStatusCustomCheckListURL);

    final queryParameters = {
      inspectionChecklistItemIDParameter: itemId.toString(),
      componentStatusIDParameter: StatusId.toString(),
    };
    final url = Uri.http(
        "dev.codepickles.com:8087", ChangeStatusCustomCheckListURL,
        queryParameters);

   // print(url);
    var response =
    await client.put(url, headers: {'Content-type': 'application/json',});
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
          fontSize: 16.0
      );
    }
    else {
      print("Failed to update component status!" + response.body.toString());
      Fluttertoast.showToast(
          msg: "Failed to update component status!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: t13_edit_text_color,
          textColor: Colors.black87,
          fontSize: 16.0
      );
    }
  }
  on Exception catch (e) {
    print(e);
    print("Failed to update component status!"+ e.toString());
    Fluttertoast.showToast(
        msg: "Failed to update component status! " ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: t13_edit_text_color ,
        textColor: Colors.black87,
        fontSize: 16.0
    );
  }

}