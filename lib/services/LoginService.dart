import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/screens/MainDashboard.dart';
import 'package:nb_utils/nb_utils.dart';

Login(String username, String password, BuildContext context) async {
  try {
    Dio dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return null;
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString("DeviceToken").toString();
    Response result = await dio.post(LoginUrl, queryParameters: {
      "Username": username,
      "Password": password,
      "Devicetoken": deviceToken
    });

    if (result.statusCode == 200) {
      var resultData = result.data;
      var temp = jsonDecode(resultData[0]);

      Map<String, dynamic> jwtData = {};
      JwtDecoder.decode(temp['access_token'])!.forEach((key, value) {
        jwtData[key] = value;
      });

      await prefs.setString("accessToken", temp['access_token']);
      await prefs.setString("refreshToken", temp['refresh_token']);
      await prefs.setString("UserID", jwtData['sub']);
      await prefs.setInt("tokenDuration", temp['expires_in']);
      await prefs.setInt("refreshDuration", temp['refresh_expires_in']);
      await prefs.setInt("tokenStartTime", jwtData['iat']);

      await prefs.setBool(prefs_DashboardFirstTimeAccess, true);

      if (prefs.getString(prefs_ApiConfigurationOption) == null) {
        await prefs.setString(prefs_ApiConfigurationOption, 'lan');
      }

      if (prefs.getInt(prefs_RefreshRate) == null) {
        await prefs.setInt(prefs_RefreshRate, 60);
      }

      var CommerceResult = jsonDecode(resultData[1]);
      await prefs.setString("StoreToken", CommerceResult["access_token"]);
      await prefs.setString(
          "StoreCustomerId", CommerceResult["customer_id"].toString());
      await prefs.setString(
          "StoreCustomerGuid", CommerceResult["customer_guid"]);

      await prefs.setBool("GuestLogin", false);
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Theme5Dashboard(),
            settings: RouteSettings(name: 'dashboard')),
      );
      prefs.setBool('IsLoggedIn', true);
      await prefs.setString("isTechnician", 'false');
      for (var item in jwtData['roles']) {
        if (item.toString() == "Technician") {
          await prefs.setString("isTechnician", 'true');
          break;
        }
      }
      await prefs.setBool('GuestLogin', false);
      SuccessToast();
      return true;
    } else {
      failLogin();
    }
  } catch (e) {
    failLogin();
    throw e;
  }
}

SuccessToast() {
  return Fluttertoast.showToast(
      msg: "Login Successfull",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black87,
      fontSize: 16.0);
}

FailedToast() {
  return Fluttertoast.showToast(
      msg: "Login Failed",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black87,
      fontSize: 16.0);
}

GuestLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool("GuestLogin", true);
  await prefs.setBool('IsLoggedIn', true);
  return true;
}

failLogin() {
  FailedToast();
  return false;
}
