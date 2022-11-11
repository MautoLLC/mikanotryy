import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/screens/SignInScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Register(String username, String firstname, String lastname, String email,
    String password, BuildContext context) async {
  try {
    Dio dio = new Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString("DeviceToken").toString();

    final body = {
      "FirstName": firstname,
      "LastName": lastname,
      "Email": email,
      "Password": password,
      "Devicetoken": token
    };

    var response = await dio.post(RegisterUrl, queryParameters: body);

    if (response.statusCode == 200) {
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
          msg: "Failed to create user ! " + response.data.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black87,
          fontSize: 16.0);
      //debugPrint("failed to create user");
    }
  } catch (e) {
    throw e;
  }
}
