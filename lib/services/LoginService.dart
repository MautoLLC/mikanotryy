import 'dart:io';
import 'dart:isolate';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/State/UserState.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/views/screens/MainDashboard.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Login(String username, String password, BuildContext context) async {
  Dio dio = new Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  };
  try {
    Response response = await dio.post((authorizationEndpoint),
        options: Options(headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        }),
        data: {
          "username": username,
          "password": password,
          "grant_type": "password",
          "client_id": "MymikanoAppLogin",
        });
    var temp = (response.data);

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

    try {
      response = await dio.post(MikanoShopTokenURL, data: {
        "guest": true,
        "username": username,
        "password": password,
        "remember_me": true
      });
      await prefs.setString("StoreToken", response.data["access_token"]);
      await prefs.setString(
          "StoreCustomerId", response.data["customer_id"].toString());
      await prefs.setString(
          "StoreCustomerGuid", response.data["customer_guid"]);
    } on Exception catch (e) {
      FailedToast();
      print(e.toString());
      return false;
    }
    try {
      await http.post(
          Uri.parse(
              "http://dev.codepickles.com:8083/api/Users/Devices/${jwtData['sub']}?deviceToken=${prefs.getString("DeviceToken")}"),
          headers: {
            "Authorization": "Bearer ${prefs.getString("accessToken")}",
            "Content-Type": "application/json"
          });
      await prefs.setBool("GuestLogin", false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Theme5Dashboard()),
      );
    } on Exception catch (e) {
      FailedToast();
      print(e.toString());
      return false;
    }
    SuccessToast();
    prefs.setBool('IsLoggedIn', true);
    await prefs.setString("isTechnician", 'false');
    for (var item in jwtData['roles']) {
      if (item.toString() == "Technician") {
        await prefs.setString("isTechnician", 'true');
        break;
      }
    }
    return true;
  } on Exception catch (e) {
    print(e);
    FailedToast();
    return false;
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

GuestLogin() async{
  Dio dio = new Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  };
    try {
    Response response = await dio.post((authorizationEndpoint),
        options: Options(headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        }),
        data: {
          "username": "petereid31@hotmail.com",
          "password": "password",
          "grant_type": "password",
          "client_id": "MymikanoAppLogin",
        });
    var temp = (response.data);

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

    try {
      response = await dio.post(MikanoShopTokenURL, data: {
        "guest": true,
        "username": "petereid31@hotmail.com",
        "password": "password",
        "remember_me": true
      });
      await prefs.setString("StoreToken", response.data["access_token"]);
      await prefs.setString(
          "StoreCustomerId", response.data["customer_id"].toString());
      await prefs.setString(
          "StoreCustomerGuid", response.data["customer_guid"]);
    } on Exception catch (e) {
      FailedToast();
      print(e.toString());
      return false;
    }
    SuccessToast();
    prefs.setBool('IsLoggedIn', true);
    return true;
    } catch (e){
      FailedToast();
      return false;
    }
}
