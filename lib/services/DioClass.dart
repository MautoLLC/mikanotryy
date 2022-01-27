import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mymikano_app/main.dart';
import 'package:mymikano_app/services/LogoutService.dart';
import 'package:mymikano_app/services/getNewTokenService.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/views/screens/SignInScreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClass {
  DioClass();

  static Future<Dio> getDio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = Dio();
    dio.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      DateTime now = new DateTime.now();
      int current = now.millisecondsSinceEpoch ~/ 1000;
      int ellapsedTime = (current - prefs.getInt('tokenStartTime')!.toInt());
      int refreshDuration = prefs.getInt('refreshDuration')!.toInt();
      int tokenDuration = prefs.getInt('tokenDuration')!.toInt();
      if (ellapsedTime > refreshDuration) {
        Fluttertoast.showToast(
            msg: "Session Expired",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: t13_edit_text_color,
            textColor: Colors.black87,
            fontSize: 16.0);
        await logout();
      } else if (ellapsedTime > tokenDuration) {
        if (await RefreshToken(prefs.getString("refreshToken").toString())) {
          options.headers["Authorization"] =
              "Bearer ${prefs.getString("accessToken")}";
          options.headers["Content-Type"] = "application/json";
          return handler.next(options);
        }
      } else {
        options.headers["Authorization"] =
            "Bearer ${prefs.getString("accessToken")}";
        options.headers["Content-Type"] = "application/json";
        return handler.next(options);
      }
    }, onResponse: (response, handler) async {
      return handler.next(response);
    }, onError: (error, handler) {
      print(error.response!.statusCode.toString());
      return handler.next(error);
    }));
    return dio;
  }
}
