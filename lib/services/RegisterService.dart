import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/screens/SignInScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Register(String username, String firstname, String lastname, String email,
    String password, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = await prefs.getString("DeviceToken").toString();

  final body = {
    "firstName": firstname,
    "lastName": lastname,
    "email": email,
    "password": password,
    "deviceToken": token
  };

  var response = await http.post(
      Uri.parse("http://dev.codepickles.com:8083/api/Users"),
      body: json.encode(body),
      headers: {
        'Content-type': 'application/json',
      });

  if (response.statusCode == 201) {
    if (prefs.getBool(prefs_DashboardFirstTimeAccess) == null) {
      await prefs.setBool(prefs_DashboardFirstTimeAccess, true);
    }

    if (prefs.getString(prefs_ApiConfigurationOption) == null) {
      await prefs.setString(prefs_ApiConfigurationOption, 'lan');
    }

    if (prefs.getInt(prefs_RefreshRate) == null) {
      await prefs.setInt(prefs_RefreshRate, 60);
    }

    Fluttertoast.showToast(
        msg: "User created successfully ! ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
        fontSize: 16.0);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => T13SignInScreen()),
    );
    // debugPrint("created successfully");

  } else {
    Fluttertoast.showToast(
        msg: "Failed to create user ! " + response.body.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
        fontSize: 16.0);
    //debugPrint("failed to create user");
  }
}
