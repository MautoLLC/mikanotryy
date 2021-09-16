import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mymikano_app/services/LogoutService.dart';

class AuthorizationInterceptor implements InterceptorContract {
  // BuildContext context;

  // AuthorizationInterceptor({required this.context});
  AuthorizationInterceptor();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == 200) {
      // await logout(context);
      print("It worked");
    }
    return data;
  }
}
