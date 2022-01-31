import 'package:flutter/cupertino.dart';
import 'package:mymikano_app/services/StoreServices/CustomerService.dart';

class UserState extends ChangeNotifier {
  bool termsAccepted = true;
  bool NotificationsEnabled = true;

  UserState() {
    fetchtermsState();
    fetchNotificationsState();
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
}
