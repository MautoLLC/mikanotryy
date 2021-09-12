import 'package:flutter/material.dart';
import 'package:mymikano_app/views/screens/SignInScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('IsLoggedIn', false);
  String token = await prefs.getString("DeviceToken").toString();
  var response = await http.delete(Uri.parse(
      "http://dev.codepickles.com:8083/api/Users/Devices/${prefs.get("UserID")}?deviceToken=${prefs.getString("DeviceToken")}"));
  print(response.statusCode);
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => T13SignInScreen()),
  );
}
