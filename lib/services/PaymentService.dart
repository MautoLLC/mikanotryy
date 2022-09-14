import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class PaymentService {
  static final PaymentService _instance = PaymentService._internal();

  factory PaymentService() => _instance;

  PaymentService._internal();

  // TODO Public key prod and dev
  var publicKey = 'pk_test_949f98de6a4c434159f774c71ce9fc0d7a6fe794';
  final plugin = PaystackPlugin();

  // generate Map of the top 100 currency codes as NGN is 566
  static Map<String, String> currencyCodes = {
    "NGN": "566",
    "USD": "840",
    "EUR": "978",
    "GBP": "826",
    "AUD": "036",
    "CAD": "124",
    "CHF": "756",
    "CNY": "156",
    "DKK": "208",
    "HKD": "344",
    "JPY": "392",
    "MXN": "484",
    "NOK": "578",
    "NZD": "554",
    "SEK": "752",
    "SGD": "702",
    "THB": "764",
    "ZAR": "710",
    "XAF": "950",
    "XCD": "951",
  };

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String _getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<void> initSdk() async {
    await plugin.initialize(publicKey: publicKey);
  }

  Future<String?> pay(
      String customer_ID,
      String customer_Name,
      String customer_Email,
      String customer_Phone,
      int amount,
      BuildContext context) async {
    Charge charge = Charge();
    charge
      ..amount = amount * 100
      ..email = customer_Email
      ..reference = _getRandomString(12)
      ..putCustomField('Charged From', 'Mikano Mobile')
      ..putCustomField('Customer ID', customer_ID)
      ..putCustomField('Customer Name', customer_Name);

    CheckoutResponse response = await plugin.checkout(
      context, charge: charge,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
    );
    return response.status ? charge.reference : "";
  }
}
