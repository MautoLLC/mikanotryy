import 'package:flutter/material.dart';
import 'package:mymikano_app/State/ApiConfigurationState.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/screens/Dashboard/CloudDashboard_Index.dart';
import 'package:mymikano_app/views/screens/Dashboard/Dashboard_Index.dart';
import 'package:mymikano_app/views/screens/Dashboard/Dashboard_Test.dart';
import 'package:mymikano_app/views/screens/Dashboard/LanDashboard_Index.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ApiConfigurationPage extends StatelessWidget {
  ApiConfigurationPage({Key? key}) : super(key: key);
  final refreshRateController = TextEditingController();
  final cloudUsernameController = TextEditingController();
  final cloudPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  bool isFirstTimeInThisPage = true;

  // Future<String> Connecttossid(String id, String pass, String cloudUsername,
  //     String cloudPassword, String cloudMode) async {
  //   final response = await http.get(Uri.parse(ssidUrl +
  //       '/setting?ssid=' +
  //       id +
  //       '&pass=' +
  //       pass +
  //       '&clouduserN=' +
  //       cloudUsername +
  //       '&cloudpassw=' +
  //       cloudPassword +
  //       '&cmode=' +
  //       cloudMode));
  //   if (response.statusCode == 200) {
  //     print(response.body.toString());
  //     return (response.body.toString());
  //   } else {
  //     return (response.body.toString());
  //   }
  // }

  // String RestartESP() {
  //   final response = http.get(Uri.parse(ssidRestartUrl));
  //   return "";
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiConfigurationState>(
      builder: (context, value, child) => Scaffold(
          body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(children: [
                  TopRowBar(title: lbl_API_Configuration),
                  SizedBox(
                    height: 35,
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    width: 120,
                    height: 120,
                    child: Image(
                      image: AssetImage(logoAsset),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  Spacer(),
                  SizedBox(
                    width: (MediaQuery.of(context).size.height) - 16,
                    child: Text(
                      txt_API_Configuration,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: value.option == 'lan'
                              ? mainColorTheme
                              : Colors.white,
                          textStyle: TextStyle(
                              color: value.option == 'lan'
                                  ? Colors.white
                                  : mainColorTheme),
                          elevation: 4,
                          side: BorderSide(width: 2.0, color: mainColorTheme),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0)),
                          padding: EdgeInsets.all(0.0),
                        ),
                        onPressed: () {
                          value.ChangeMode('lan');
                        },
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.0, vertical: 12.0),
                            child: Text(
                              lbl_LAN,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: value.option == 'lan'
                                      ? Colors.white
                                      : mainColorTheme),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )),
                      SizedBox(width: 10),
                      Expanded(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: value.option == 'cloud'
                              ? mainColorTheme
                              : Colors.white,
                          textStyle: TextStyle(
                              color: value.option == 'cloud'
                                  ? Colors.white
                                  : mainColorTheme),
                          elevation: 4,
                          side: BorderSide(width: 2.0, color: mainColorTheme),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0)),
                          padding: EdgeInsets.all(0.0),
                        ),
                        onPressed: () {
                          value.ChangeMode('cloud');
                        },
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.0, vertical: 12.0),
                            child: Text(
                              lbl_Cloud,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: value.option == 'cloud'
                                      ? Colors.white
                                      : mainColorTheme),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )),
                      SizedBox(width: 10),
                      Expanded(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: value.option == 'comap'
                              ? mainColorTheme
                              : Colors.white,
                          textStyle: TextStyle(
                              color: value.option == 'comap'
                                  ? Colors.white
                                  : mainColorTheme),
                          elevation: 4,
                          side: BorderSide(width: 2.0, color: mainColorTheme),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0)),
                          padding: EdgeInsets.all(0.0),
                        ),
                        onPressed: () {
                          value.ChangeMode('comap');
                        },
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.0, vertical: 12.0),
                            child: Text(
                              lbl_Comap,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: value.option == 'comap'
                                      ? Colors.white
                                      : mainColorTheme),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 55,
                  ),
                  Spacer(),
                  if (value.DashBoardFirstTimeAccess == true) ...[
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: mainGreyColorTheme)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                isExpanded: true,
                                hint: Text(
                                  lbl_SSID,
                                  style: TextStyle(
                                      color: mainGreyColorTheme,
                                      fontWeight: FontWeight.bold),
                                ),
                                borderRadius: BorderRadius.circular(20),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: mainGreyColorTheme,
                                ),
                                items:
                                    value.ssidList.map(buildMenuItem).toList(),
                                value: value.chosenSSID,
                                onChanged: (item) {
                                  String string = item.toString();
                                  final splitted = string.split('(');
                                  value.ComboBoxState(splitted[0]);
                                }),
                          ),
                        ),
                        SizedBox(height: 20),
                        t13EditTextStyle(lbl_hint_password, passwordController),
                        SizedBox(height: 20),
                        TextFormField(
                          onChanged: (username) =>
                              value.changeCloudUsername(username),
                          style: TextStyle(
                              fontSize: textSizeMedium,
                              fontFamily: PoppinsFamily),
                          obscureText: false,
                          cursorColor: black,
                          controller: cloudUsernameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(26, 14, 4, 14),
                            hintText: lbl_Cloud_Username,
                            hintStyle:
                                primaryTextStyle(color: textFieldHintColor),
                            filled: true,
                            fillColor: lightBorderColor,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 0.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        t13EditTextStyle(
                            lbl_Cloud_Password, cloudPasswordController),
                        SizedBox(height: 20),

                        SizedBox(height: 30),
                        T13Button(
                            textContent: lbl_Fetch_Generator_Ids,
                            onPressed: () async {
                              value.getGeneratorIds(
                                  cloudUsernameController.text,
                                  cloudPasswordController.text);
                              // await Connecttossid(
                              //     value.chosenSSID,
                              //     passwordController.text,
                              //     cloudUsernameController.text,
                              //     cloudPasswordController.text,
                              //     value.cloudMode.toString());
                              // RestartESP();
                            }),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       'Cloud Mode',
                        //       style: TextStyle(fontSize: 17.0),
                        //     ), //Text
                        //     SizedBox(width: 10),
                        //     Checkbox(
                        //       value: value.cloudModeValue,
                        //       onChanged: (bool? option) {
                        //         value.changeCloudMode(option);
                        //       },
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 30),

                        if (value.isSuccess && !isFirstTimeInThisPage)
                          Container(
                              width: MediaQuery.of(context).size.width - 16,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: GreenColor.withOpacity(0.1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: GreenColor),
                                      child: Icon(
                                        Icons.check_sharp,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                  Text(lbl_Test_Success)
                                ],
                              )),
                        if (!value.isSuccess && !isFirstTimeInThisPage)
                          Container(
                              width: MediaQuery.of(context).size.width - 16,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: mainColorTheme.withOpacity(0.1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Icon(Icons.error,
                                          color: mainColorTheme, size: 20)),
                                  Text(lbl_Test_Failed)
                                ],
                              )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: mainGreyColorTheme)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                isExpanded: true,
                                hint: Text(
                                  lbl_Generator_ID,
                                  style: TextStyle(
                                      color: mainGreyColorTheme,
                                      fontWeight: FontWeight.bold),
                                ),
                                borderRadius: BorderRadius.circular(20),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: mainGreyColorTheme,
                                ),
                                items: value.generatorIdList
                                    .map(buildMenuItem)
                                    .toList(),
                                value: value.chosenGeneratorId,
                                onChanged: (item) {
                                  String string = item.toString();
                                  final splitted = string.split('(');
                                  value.ChooseGenerator(splitted[0]);
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (rate) =>
                              value.changeRefreshRate(int.parse(rate)),
                          style: TextStyle(
                              fontSize: textSizeMedium,
                              fontFamily: PoppinsFamily),
                          obscureText: false,
                          cursorColor: black,
                          controller: refreshRateController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(26, 14, 4, 14),
                            hintText: lbl_Default_Refresh_Rate,
                            hintStyle:
                                primaryTextStyle(color: textFieldHintColor),
                            filled: true,
                            fillColor: lightBorderColor,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 0.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  ],
                  Spacer(),
                  T13Button(
                      textContent: lbl_Save,
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        if (value.DashBoardFirstTimeAccess == true) {
                          value.setpref(
                              value.chosenSSID,
                              passwordController.text,
                              int.parse(refreshRateController.text),
                              cloudUsernameController.text,
                              cloudPasswordController.text,
                              value.cloudMode,
                              value.chosenGeneratorId);
                        }

                        // await value.service.Connecttossid(
                        //     value.chosenSSID,
                        //     passwordController.text,
                        //     cloudUsernameController.text,
                        //     cloudPasswordController.text,
                        //     value.cloudMode.toString(),
                        //     value.chosenGeneratorId);
                        // value.service.RestartESP();

                        if (value.option == 'cloud') {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CloudDashboard_Index(
                                  /* ApiEndPoint:
                                      "https//iotapi.mauto.co/api/generators/values/",*/
                                  RefreshRate: value.RefreshRate)));
                        } else if (value.option == 'comap') {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Dashboard_Index()));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LanDashboard_Index(
                                    RefreshRate: value.RefreshRate,
                                  )));
                        
                        }
                        value.isNotFirstTime();
                        prefs.setBool(prefs_DashboardFirstTimeAccess, false);
                      }),
                  SizedBox(
                    height: 25,
                  )
                ]),
              ),
            )
          ],
        ),
      )),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String selectedSSID) =>
      DropdownMenuItem(value: selectedSSID, child: Text(selectedSSID));
}
