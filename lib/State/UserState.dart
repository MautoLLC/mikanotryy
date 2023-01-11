import 'package:flutter/cupertino.dart';
import 'package:mymikano_app/models/StoreModels/AddressModel.dart';
import 'package:mymikano_app/models/TechnicianModel.dart';
import 'package:mymikano_app/services/StoreServices/CustomerService.dart';
import 'package:mymikano_app/services/UserService.dart';
import 'package:nb_utils/nb_utils.dart';

class UserState extends ChangeNotifier {
  TechnicianModel User = TechnicianModel("1", 'null', '', 'null', 'null');
  String Role = "user";
  bool termsAccepted = true;
  bool NotificationsEnabled = true;
  Address ChosenAddress = Address();
  bool checkedValueForOrder = false;
  bool guestLogin = true;
  List<Address> listofAddresses = [];

  void clear() {
    User = TechnicianModel("1", 'null', '', 'null', 'null');
    Role = "user";
    termsAccepted = true;
    NotificationsEnabled = true;
    ChosenAddress = Address();
    checkedValueForOrder = false;
    notifyListeners();
  }

  update() async {
    fillUserInfo();
    fetchtermsState();
    fetchNotificationsState();
    fetchAddress();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    guestLogin = await prefs.getBool("GuestLogin")!;
    notifyListeners();
  }

  fetchAllAddresses() async {
    listofAddresses =
        await CustomerService().GetShippingAddressesForLoggedInUser();
    notifyListeners();
  }

  deleteAddress(int id) async {
    if (await CustomerService().deleteAddress(id))
      listofAddresses.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void fillUserInfo() async {
    User = await UserService().GetUserInfo();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Role = prefs.getString("Role").toString();
    notifyListeners();
  }

  void updateUserInfo(
      String firstName, String lastName, String PhoneNumber) async {
    bool flag =
        await UserService().EditUserInfo(firstName, lastName, PhoneNumber);
    if (flag) {
      User.username = firstName + " " + lastName;
      User.phoneNumber = PhoneNumber;
    }
    notifyListeners();
  }

  Future<void> setcheckedValueForOrder(bool value) async {
    checkedValueForOrder = value;
    notifyListeners();
  }

  Future<void> addAddress(String address, String city) async {
    debugPrint(User.phoneNumber);
    debugPrint(User.phoneNumber.isEmptyOrNull.toString());
    if (User.phoneNumber.isEmptyOrNull) {
      toast("Please Add a phone number first");
      return;
    }
    Address newAddress = Address(
        address1: address,
        city: city,
        firstName: User.username,
        lastName: User.username,
        email: User.email,
        countryId: 2,
        stateProvinceId: 2,
        zipPostalCode: "1001",
        phoneNumber: User.phoneNumber);
    ChosenAddress = newAddress;
    if (await CustomerService().addShippingAddress(newAddress) &&
        !listofAddresses
            .any((element) => element.address1 == newAddress.address1)) {
      listofAddresses.add(newAddress);
    } else {
      newAddress.chosen = true;
    }
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
    if (await CustomerService().setTermsState(state)) {
      termsAccepted = state;
    }
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
