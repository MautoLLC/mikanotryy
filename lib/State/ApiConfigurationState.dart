import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ApiConfigurationState extends ChangeNotifier {
  bool DashBoardFirstTimeAccess = true;
  bool isSuccess = false;
  String option = 'lan';
  var chosenSSID;
  int RefreshRate = 60;
  String password = '';
  List<String> ssidList = [];

  ApiConfigurationState() {
    update();
    ShowSSIDs();
  }

  void ChangeMode(String value) async {
    option = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ApiConfigurationOption', option);
    print(prefs.getString('ApiConfigurationOption'));
    notifyListeners();
  }

  void update() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DashBoardFirstTimeAccess = prefs.getBool('DashboardFirstTimeAccess')!;
    option = prefs.getString('ApiConfigurationOption')!;
    RefreshRate = prefs.getInt('RefreshRate')!;
    password = prefs.getString('Password')!;
    chosenSSID = prefs.getString('SSID');
    notifyListeners();
  }

  void ChangeSuccessState(String ssid, String password) {
    if (ssid == '' && password == '') {
      isSuccess = false;
    } else
      isSuccess = true;

    notifyListeners();
  }

  changeRefreshRate(int rate) {
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
    ssidList.clear();
    List<String> l = [
      'ssid1',
      'ssid2',
      'ssid3',
      'ssid4',
      'ssid5',
    ];

    l.forEach((element) {
      ssidList.add(element);
    });
    notifyListeners();
  }

  void ComboBoxState(String splitted) {
    chosenSSID = splitted;
    notifyListeners();
  }

  void clear() {
    DashBoardFirstTimeAccess = true;
    isSuccess = false;
    option = 'lan';
    chosenSSID = null;
    RefreshRate = 60;
    password = '';
    ssidList = [];
    notifyListeners();
  }

  void resetPreferences() async {
    clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('DashboardFirstTimeAccess', true);
    prefs.remove('SSID');
    prefs.remove('Password');
    prefs.remove('RefreshRate');
    ShowSSIDs();
    notifyListeners();
  }

  void setpref(ssid, password, int refreshRate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('SSID', ssid);
    prefs.setString('Password', password);
    prefs.setInt('RefreshRate', refreshRate);
  }
}
