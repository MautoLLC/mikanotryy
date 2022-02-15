import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mymikano_app/models/StoreModels/AddressModel.dart';
import 'package:mymikano_app/models/TechnicianModel.dart';
import 'package:mymikano_app/services/StoreServices/CustomerService.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';

class UserState extends ChangeNotifier {
  TechnicianModel User =
      TechnicianModel(1, 'null', '', 'null', 'null');
  bool termsAccepted = true;
  bool NotificationsEnabled = true;
  Address ChosenAddress = Address();
  bool checkedValueForOrder = false;

  UserState() {
    fillUserInfo();
    fetchtermsState();
    fetchNotificationsState();
    fetchAddress();
    notifyListeners();
  }

  void fillUserInfo() async {
    Directory directory;
    File file;
    String fileContent;
    directory = await getApplicationDocumentsDirectory();
    file = File('${directory.path}/credentials.json');
    fileContent = await file.readAsString();
    Map<String, dynamic> jwtData = {};

    JwtDecoder.decode(fileContent)!.forEach((key, value) {
      jwtData[key] = value;
    });
    User = new TechnicianModel(
        1,
        jwtData['given_name'].toString() +
            " " +
            jwtData['family_name'].toString(),
        '',
        "null",
        jwtData['email']);
  }

  void updateUserInfo(String Username, String Email, String PhoneNumber) async {
    User.username = Username;
    User.email = Email;
    User.phoneNumber = PhoneNumber;
    // ToDo: Update user info in db
    notifyListeners();
  }

  Future<void> setcheckedValueForOrder(bool value) async {
    checkedValueForOrder = value;
    notifyListeners();
  }

  Future<void> addAddress(String address, String city) async {
    Address newAddress = Address(address1: address, city: city);
    ChosenAddress = newAddress;
    await CustomerService().addShippingAddress(newAddress);
    notifyListeners();
  }

  Future<void> fetchAddress() async {
    ChosenAddress =
        await CustomerService().GetShippingAddresseForLoggedInUser();
    notifyListeners();
  }

  Future<void> fetchNotificationsState() async {
    NotificationsEnabled = await CustomerService().getNotificationsState();
    notifyListeners();
  }

  Future<void> setNotificationsState(bool state) async {
    NotificationsEnabled = await CustomerService().setNotificationsState(state);
    notifyListeners();
  }

  Future<void> fetchtermsState() async {
    termsAccepted = await CustomerService().getTermsState();
    notifyListeners();
  }

  Future<void> setTermsState(bool state) async {
    termsAccepted = await CustomerService().setTermsState(state);
    notifyListeners();
  }

  bool get getTermsState => termsAccepted;

  Future<void> sendContactUsRequest(
      String name, String email, String message) async {
    await CustomerService().postContactUsRequest(name, email, message);
    notifyListeners();
  }

  TechnicianModel get getUser => User;
}
