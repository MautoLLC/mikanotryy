import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/views/screens/MainDashboard.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

Login(String username, String password, BuildContext context) async {

  final secrett = '';
  try {
    var client = await oauth2.resourceOwnerPasswordGrant(
        Uri.parse(authorizationEndpoint), username, password,
        identifier: "MymikanoAppLogin", secret: secrett);

    final directory = await getApplicationDocumentsDirectory();
    String appDocPath = directory.path;
    File('$appDocPath/credentials.json').writeAsString(
        client.credentials.toJson());
    // print(client.credentials.expiration);
    File file = File('$appDocPath/credentials.json'); //
    String fileContent = await file.readAsString();
    //print("file cont" + fileContent);
    Fluttertoast.showToast(
        msg: "Login Successfull \n" ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: t13_edit_text_color ,
        textColor: Colors.black87,
        fontSize: 16.0
    );
    Navigator.push(
       context,
      MaterialPageRoute(
          builder: (context) => Theme5Dashboard()),
    );

  }

  on Exception catch (e) {
    print(e);

    Fluttertoast.showToast(
        msg: "Login Failed \n" + e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: t13_edit_text_color ,
        textColor: Colors.black87,
        fontSize: 16.0
    );


  }



  //   FormatException

}