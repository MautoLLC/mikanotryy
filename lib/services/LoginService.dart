import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/views/screens/MainDashboard.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:http/http.dart' as http;

Login(String username, String password, BuildContext context) async {
  final secrett = '';
  try {
    var client = await oauth2.resourceOwnerPasswordGrant(
        Uri.parse(authorizationEndpoint), username, password,
        identifier: "MymikanoAppLogin", secret: secrett);

    final directory = await getApplicationDocumentsDirectory();
    String appDocPath = directory.path;
    File('$appDocPath/credentials.json')
        .writeAsString(client.credentials.accessToken);
    File file = File('${directory.path}/credentials.json'); //
    String fileContent = await file.readAsString();
    print(fileContent);
    Map<String, dynamic> jwtData = {};
    JwtDecoder.decode(fileContent)!.forEach((key, value) {
      jwtData[key] = value;
      print("$key ===>>> $value");
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("UserID", jwtData['sub']);
    Fluttertoast.showToast(
        msg: "Login Successfull",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: t13_edit_text_color,
        textColor: Colors.black87,
        fontSize: 16.0);
    prefs.setBool('IsLoggedIn', true);
    print(prefs.get("UserID"));
    print(prefs.getString("DeviceToken"));
    try {
      String token = await prefs.getString("DeviceToken").toString();
      var response = await http.post(Uri.parse(
          "http://dev.codepickles.com:8083/api/Users/Devices/${jwtData['sub']}?deviceToken=${prefs.getString("DeviceToken")}"));
      print(response.statusCode);
      print(response.reasonPhrase);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Theme5Dashboard()),
      );
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: "Login Failed" + e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: t13_edit_text_color,
          textColor: Colors.black87,
          fontSize: 16.0);
      print(e.toString());
    }
  } on Exception catch (e) {
    print(e);
    Fluttertoast.showToast(
        msg: "Login Failed" + e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: t13_edit_text_color,
        textColor: Colors.black87,
        fontSize: 16.0);
  }
}
