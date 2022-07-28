import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymikano_app/State/ApiConfigurationState.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/screens/Dashboard/CloudDashboard_Index.dart';
import 'package:mymikano_app/views/screens/Dashboard/Dashboard_Index.dart';
import 'package:mymikano_app/views/screens/Dashboard/LanDashboard_Index.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class ApiConfigurationPagee extends StatelessWidget {
  ApiConfigurationPagee({Key? key}) : super(key: key);
  final refreshRateController = TextEditingController();
  final cloudUsernameController = TextEditingController();
  final cloudPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final apiEndpointLanController = TextEditingController(text: lanESPUrl);
  bool isFirstTimeInThisPage = true;

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
                  Container(
                    alignment: Alignment.center,
                    width: 120,
                    height: 120,
                    child: Image(
                      image: AssetImage(logoAsset),
                      fit: BoxFit.cover,
                    ),
                  ),
                    // if (value.DashBoardFirstTimeAccess == true) ...[
                      Expanded(
                        child: Column(children: [
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
                          SizedBox(height: 10),
                          if (value.isSuccess == true && value.Message != "")
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
                                    Text(value.Message)
                                  ],
                                )),
                          if (value.isSuccess == false && value.Message != "")
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
                                    Text(value.Message)
                                  ],
                                )),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                width: MediaQuery.of(context).size.width / 2.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                        Border.all(color: mainGreyColorTheme)),
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
                                      items: value.generatorNameList
                                          .map(buildMenuItem)
                                          .toList(),
                                      value: value.chosenGeneratorName,
                                      onChanged: (item) {
                                        value.ChooseGeneratorName(
                                            item.toString());
                                        int i = (value.gens).indexWhere(
                                            (element) =>
                                                element.name == item.toString());
                                        value.setChosenGeneratorId(
                                            value.gens.elementAt(i).generatorId);
                                      }),
                                ),
                              ),
                  ]),

    ]),
      ),
    //]
]),
    ),
    )
          ]
    ),
    ),
    ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String selectedSSID) =>
      DropdownMenuItem(value: selectedSSID, child: Text(selectedSSID));
}

enum ConfigValue { withConfig, withoutConfig }
