import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/views/screens/MainDashboard.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

Login(String username, String password, BuildContext context) async {
  try {
    final response =
        await http.post(Uri.parse(authorizationEndpoint), headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    }, body: {
      "username": username,
      "password": password,
      "grant_type": "password",
      "client_id": "MymikanoAppLogin",
    });
    var temp = jsonDecode(response.body);

    final directory = await getApplicationDocumentsDirectory();
    String appDocPath = directory.path;
    File('$appDocPath/credentials.json').writeAsString(temp['access_token']);
    File file = File('${directory.path}/credentials.json');
    String fileContent = await file.readAsString();

    Map<String, dynamic> jwtData = {};
    JwtDecoder.decode(fileContent)!.forEach((key, value) {
      jwtData[key] = value;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("accessToken", temp['access_token']);
    await prefs.setString("refreshToken", temp['refresh_token']);
    await prefs.setString("UserID", jwtData['sub']);
    await prefs.setInt("tokenDuration", temp['expires_in']);
    await prefs.setInt("refreshDuration", temp['refresh_expires_in']);
    await prefs.setInt("tokenStartTime", jwtData['iat']);
    print(prefs.getInt('tokenDuration'));

    Fluttertoast.showToast(
        msg: "Login Successfull",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: t13_edit_text_color,
        textColor: Colors.black87,
        fontSize: 16.0);
    prefs.setBool('IsLoggedIn', true);
    try {
      String token = await prefs.getString("DeviceToken").toString();
      var response = await http.post(Uri.parse(
          "http://dev.codepickles.com:8083/api/Users/Devices/${jwtData['sub']}?deviceToken=${prefs.getString("DeviceToken")}"));
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
