import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/services/LogoutService.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';

RefreshToken(String refreshToken) async {
  Dio dio = new Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return null;
  };
  try {
    Response response = await dio.post((authorizationEndpoint),
        options: Options(headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        }),
        data: {
          "refresh_token": refreshToken,
          "grant_type": "refresh_token",
          "client_id": "MymikanoAppLogin",
        });
    if (response.statusCode == 200) {
      var temp = (response.data);
      final directory = await getApplicationDocumentsDirectory();
      String appDocPath = directory.path;
      File('$appDocPath/credentials.json').writeAsString(temp['access_token']);
      File file = File('${directory.path}/credentials.json'); //
      String fileContent = await file.readAsString();

      Map<String, dynamic> jwtData = {};
      JwtDecoder.decode(fileContent)!.forEach((key, value) {
        jwtData[key] = value;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("accessToken", temp['access_token']);
      // await prefs.setString("refreshToken", temp['refresh_token']);
      await prefs.setInt("tokenDuration", jwtData['exp'] - jwtData['iat']);
      await prefs.setInt("tokenStartTime", jwtData['iat']);
      return true;
    } else {
      Fluttertoast.showToast(
          msg: "Session Expired",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black87,
          fontSize: 16.0);
      await logout();
      return false;
    }
  } on Exception catch (e) {
    Fluttertoast.showToast(
        msg: "Session Expired" + e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
        fontSize: 16.0);
    await logout();
    return false;
  }
}
