import 'package:flutter/material.dart';

class ApiConfigurationState extends ChangeNotifier {
  bool isLAN = true;
  bool isSuccess = false;

  void ChangeMode(bool value) {
    isLAN = value;
    notifyListeners();
  }

  void ChangeSuccessState(String ssid, String password) {
    if (ssid == '' && password == '') {
      isSuccess = false;
    } else
      isSuccess = true;

    notifyListeners();
  }
}
