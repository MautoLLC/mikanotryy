import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/models/Currency.dart';
import 'package:mymikano_app/utils/appsettings.dart';

import 'DioClass.dart';

class CurrencyService {
  late Dio dio;

  Future<void> PrepareCall() async {
    dio = await DioClass.getDio();
  }

  Future<Currency?> getPrimaryCurrency() async {
    Response response;
    Currency? currency;
    try {
      response = await Dio().get(MikanoShopPrimaryCurrency);
      currency = Currency.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
    return currency;
  }
}
