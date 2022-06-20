import 'dart:math';

import 'package:flutter/services.dart';
import 'package:isw_mobile_sdk/isw_mobile_sdk.dart';

class PaymentService {
  PaymentService();

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String _getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  // messages to SDK are asynchronous, so we initialize in an async method.
  Future<void> initSdk() async {
    // messages may fail, so we use a try/catch PlatformException.
    try {
      String merchantId = "IKIA4CC6EB8D10397B7361C0DE33FBE4A852F2147614",
          merchantCode = "MX90186",
          merchantSecret = "28yytagm991ulDt",
          currencyCode = "840"; // e.g  566 for NGN

      var config = new IswSdkConfig(
          merchantId, merchantSecret, merchantCode, currencyCode);

      // initialize the sdk
      await IswMobileSdk.initialize(config);
      // intialize with environment, default is Environment.TEST
      // IswMobileSdk.initialize(config, Environment.SANDBOX);

    } on PlatformException {}
  }

  Future<bool> pay(String customer_ID, String customer_Name,
      String customer_Email, String customer_Phone, int amount) async {
    var customerId = customer_ID,
        customerName = customer_Name,
        customerEmail = customer_Email,
        customerMobile = customer_Phone,
        // generate a unique random
        // reference for each transaction
        reference = _getRandomString(20);

    // initialize amount
    // amount expressed in lowest
    // denomination (e.g. kobo): "N500.00" -> 50000
    int amountInKobo = amount * 100;

    // create payment info
    var iswPaymentInfo = new IswPaymentInfo(customerId, customerName,
        customerEmail, customerMobile, reference, amountInKobo);

    // trigger payment
    var result = await IswMobileSdk.pay(iswPaymentInfo);

    // process result
    return result.value.isSuccessful;
  }
}
