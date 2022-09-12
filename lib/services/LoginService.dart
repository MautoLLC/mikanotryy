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
  Dio dio = new Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return null;
  };
  int attempts = 0;
  var response;
  do {
    response = await http.post(Uri.parse(authorizationEndpoint), headers: {
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    }, body: {
      "username": username,
      "password": password,
      "grant_type": "password",
      "client_id": "MymikanoAppLogin",
    });
  } while (response.statusCode != 200 && attempts++ != 3);
  if (response.statusCode != 200) {
    return failLogin();
  }
  attempts = 0;
  var temp = jsonDecode(response.body);

  Map<String, dynamic> jwtData = {};
  JwtDecoder.decode(temp['access_token'])!.forEach((key, value) {
    jwtData[key] = value;
  });

  SharedPreferences prefs = await SharedPreferences.getInstance();

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

  do {
    response = await dio.post((MikanoShopTokenURL), data: {
      "guest": true,
      "username": username,
      "password": password,
      "remember_me": true
    });
  } while (response.statusCode != 200 && attempts++ != 3);
  if (response.statusCode != 200) {
    return failLogin();
  }
  attempts = 0;
  await prefs.setString("StoreToken", response.data["access_token"]);
  await prefs.setString(
      "StoreCustomerId", response.data["customer_id"].toString());
  await prefs.setString("StoreCustomerGuid", response.data["customer_guid"]);
  var tempResponse;
  do {
    print(prefs.getString("DeviceToken").toString());
    tempResponse = await http.post(
        Uri.parse(DeviceUrl.replaceAll("{sub}", jwtData['sub'])
            .replaceAll("{token}", prefs.getString("DeviceToken").toString())),
        headers: {
          "Authorization": "Bearer ${prefs.getString("accessToken")}",
          "Content-Type": "application/json"
        });
    print(tempResponse.reasonPhrase);
    print(tempResponse.statusCode);
  } while (tempResponse.statusCode != 200 && attempts++ != 3);
  if (tempResponse.statusCode != 200) {
    return failLogin();
  }
  attempts = 0;
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
