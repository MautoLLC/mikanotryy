import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ApiConfigurationState extends ChangeNotifier {
  bool DashBoardFirstTimeAccess = true;
  bool isSuccess = false;
  String? option;
  bool isFirstTime = true;
  var item;
  String? RefreshRate, password;
  List<String> testList = [];

  void ChangeMode(String value) async {
    option = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ApiConfigurationOption', option!);
    print(prefs.getString('ApiConfigurationOption'));
    notifyListeners();
  }

  void ChangeSuccessState(String ssid, String password) {
    if (ssid == '' && password == '') {
      isSuccess = false;
    } else
      isSuccess = true;

    notifyListeners();
  }

  changeRefreshRate(String rate) {
    RefreshRate = rate;
    notifyListeners();
  }

  // Future<List<String>> getSSIDList() async {
  //   final response = await http.get(Uri.parse("http://192.168.4.1"));
  //   if (response.statusCode == 200) {
  //     print(response.body.toString());
  //     dom.Document document = parse(response.body);

  //     document
  //         .getElementsByTagName('li')
  //         .map((e) => e.innerHtml)
  //         .forEach((element) {
  //       print(element);
  //       ssids.add(element);
  //     });
  //     return ssids;
  //   } else {
  //     print(response.body.toString());
  //     return ssids;
  //   }
  // }

  void ShowSSIDs() {
    testList.clear();
    List<String> l = [
      'ssid1',
      'ssid2',
      'ssid3',
      'ssid4',
      'ssid5',
    ];

    l.forEach((element) {
      testList.add(element);
    });
    notifyListeners();
  }

  void ComboBoxState(String splitted) {
    item = splitted;
    notifyListeners();
  }

  void resetPreferences() async {
    DashBoardFirstTimeAccess = true;
    password = null;
    RefreshRate = null;
    item = null;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('SSID');
    prefs.remove('Password');
    prefs.remove('RefreshRate');
    notifyListeners();
  }

  void setpref(ssid, password, int refreshRate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('SSID', ssid);
    prefs.setString('Password', password);
    prefs.setInt('RefreshRate', refreshRate);
  }
}
