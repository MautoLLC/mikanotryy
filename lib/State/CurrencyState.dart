import 'package:flutter/material.dart';
import 'package:mymikano_app/models/Currency.dart';
import 'package:mymikano_app/services/CurrencyService.dart';

class CurrencyState extends ChangeNotifier {
  Currency? currency;

  CurrencyState() {
    update();
  }

  update(){
    updateCurrency();
  }

  updateCurrency() async{
    currency = await CurrencyService().getPrimaryCurrency();
    notifyListeners();
  }
}