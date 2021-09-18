import 'package:flutter/material.dart';
import 'package:mymikano_app/main.dart';
import 'package:mymikano_app/views/screens/SignInScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var response = await http.delete(Uri.parse(
      "http://dev.codepickles.com:8083/api/Users/Devices/${prefs.get("UserID")}?deviceToken=${prefs.getString("DeviceToken")}"));
  prefs.clear();
  await prefs.setBool('IsLoggedIn', false);
  print(response.statusCode);
  navigator.currentState!.pushReplacement(
    MaterialPageRoute(builder: (context) => T13SignInScreen()),
  );
}
