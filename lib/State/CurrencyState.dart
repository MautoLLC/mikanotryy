import 'package:flutter/material.dart';
import 'package:mymikano_app/models/Currency.dart';
import 'package:mymikano_app/services/CurrencyService.dart';

class CurrencyState extends ChangeNotifier {
  Currency currency =
      Currency.fromJson({"name": "Naira", "currency_code": "NGN"});

  CurrencyState() {
    update();
  }

  update() {
    updateCurrency();
  }

  updateCurrency() async {
    Currency? response = await CurrencyService().getPrimaryCurrency();
    if (response != null) {
      currency = response;
    }
    notifyListeners();
  }
}
