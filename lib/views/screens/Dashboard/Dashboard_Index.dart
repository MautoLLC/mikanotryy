import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymikano_app/models/Sensor_Model.dart';
import 'package:mymikano_app/models/Token_Model.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/viewmodels/DashBoard_ModelView.dart';
import 'package:mymikano_app/views/screens/Dashboard/GeneratorAlertsPage.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/GaugeWidget.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:nb_utils/nb_utils.dart';

import 'ApiConfigurationPage.dart';

class Dashboard_Index extends StatefulWidget {
  @override
  _Dashboard_IndexState createState() => _Dashboard_IndexState();
}

class _Dashboard_IndexState extends State<Dashboard_Index> {
  late Token UserToken;
  late Timer timer;
  late Sensor EngineState;
  late Sensor BreakState;
  late Sensor RunningHours;
  late String Hours;
  late String Minutes;
  late Sensor Rpm;
  late Sensor BatteryVoltage;
  late Sensor OilPressure;
  late Sensor CoolantTemp;
  late Sensor FuelLevel;
  late Sensor GeneratorVoltage;
  late Sensor GeneratorFrequency;
  late Sensor GeneratorLoad;
  late Sensor ControllerMode;
  late bool ControllerModeStatus;
  late bool PowerStatus;
  late DashBoard_ModelView DashModelView;
  //This function is to fetch the data and await rest apis //
  Future<bool> FetchData() async {
    try {
      DashModelView = new DashBoard_ModelView();
      await DashModelView.GetUserToken();
      await DashModelView.getListGuid();
      await DashModelView.GetUnitValues();
      EngineState = DashModelView.GetEngineState();
      BreakState = DashModelView.GetBreakerState();
      RunningHours = DashModelView.GetRunningHours();
      Hours = RunningHours.value.toString();
      Minutes = RunningHours.value.toString() != "Restricted"
          ? ((double.parse(RunningHours.value.toString()) -
                      double.parse(Hours)) *
                  60)
              .round()
              .toString()
          : "Restricted";
      Rpm = DashModelView.GetRPM();
      BatteryVoltage = DashModelView.GetBattryVoltage();
      OilPressure = DashModelView.GetOilPressure();
      CoolantTemp = DashModelView.GetCoolantTemp();
      FuelLevel = DashModelView.GetFuelLevel();
      GeneratorVoltage = DashModelView.GetGeneratorVoltage();
      GeneratorFrequency = DashModelView.GetGeneratorFrequency();
      GeneratorLoad = DashModelView.GetGeneratorLoad();
      ControllerMode = DashModelView.GetControllerMode();
      if (ControllerMode.value == "AUTO")
        ControllerModeStatus = true;
      else
        ControllerModeStatus = false;

      if (EngineState.value == "Loaded" || EngineState.value == "Running")
        PowerStatus = true;
      else
        PowerStatus = false;

      return true;
    } on Exception {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  late bool isManual = ControllerModeStatus;
  late bool isIO = false;
  late bool isMCB = false;
  late bool isGCB = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FutureBuilder(
                future: FetchData(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<bool> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SpinKitCircle(
                            color: Colors.black,
                            size: 65,
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Custom_Alert(
                          Title: 'Error Has Occured',
                          Description:
                              "Something Went Wrong!, Please Check Your Internet Connection And Wait For The Next Reload.");
                    } else {
                      return Column(children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: backArrowColor,
                              ),
                              onPressed: () {
                                finish(context);
                              },
                            ),
                            Spacer(),
                            TitleText(
                              title: lbl_Generator,
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ApiConfigurationPage()));
                                },
                                icon: Icon(Icons.settings)),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          GeneratorAlertsPage()));
                                },
                                child: commonCacheImageWidget(ic_error, 22))
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: mainGreyColorTheme2,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                            child: DropdownButton(
                              onChanged: (value) {},
                              underline: Divider(
                                thickness: 0.0,
                                color: Colors.transparent,
                              ),
                              isExpanded: true,
                              hint: lbl_Generator == ""
                                  ? Text(
                                      lbl_Generator,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: PoppinsFamily,
                                          color: DropDownHintTextColor),
                                    )
                                  : Text(
                                      lbl_Generator,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: PoppinsFamily,
                                          color: DropDownHintTextColor),
                                    ),
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconEnabledColor: mainGreyColorTheme,
                              iconDisabledColor: mainGreyColorTheme,
                              items: [
                                DropdownMenuItem(
                                    value: lbl_Generator,
                                    child: new Text(lbl_Generator)),
                                DropdownMenuItem(
                                    value: lbl_Generator,
                                    child: new Text(lbl_Generator))
                              ],
                              // onChanged: (Entry? value) {
                              //   setState(() {
                              //     selectedSubCateg = value!.title;
                              //     selectedSubCategId = value.idEntry;
                              //   });
                              // },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                    height: 160,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      color: mainGreyColorTheme2,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: GaugeWidget(
                                        title: lbl_RPM,
                                        value: ((Rpm.value) / 100))),
                                SizedBox(height: 10),
                                Container(
                                    height: 160,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      color: mainGreyColorTheme2,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: GaugeWidget(
                                        title: lbl_Actual_Power,
                                        value: ((Rpm.value) / 100),
                                        needleColor: mainColorTheme)),
                              ],
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: [
                                Container(
                                  width: 167,
                                  height: 89,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 25),
                                  decoration: BoxDecoration(
                                    color: mainGreyColorTheme2,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      SubTitleText(title: lbl_Mode),
                                      Row(
                                        children: [
                                          Text(
                                            isManual ? lbl_Manual : lbl_Auto,
                                            style: TextStyle(
                                                fontFamily: PoppinsFamily,
                                                fontSize: 14,
                                                color: mainGreyColorTheme),
                                          ),
                                          Spacer(),
                                          Switch(
                                              value: isManual,
                                              onChanged: (result) {
                                                // TODO logic
                                                isManual = result;
                                                setState(() {});
                                              })
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 167,
                                  height: 89,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 25),
                                  decoration: BoxDecoration(
                                    color: mainGreyColorTheme2,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      SubTitleText(title: lbl_IO),
                                      Row(
                                        children: [
                                          Text(
                                            isIO ? lbl_ON : lbl_OFF,
                                            style: TextStyle(
                                                fontFamily: PoppinsFamily,
                                                fontSize: 14,
                                                color: mainGreyColorTheme),
                                          ),
                                          Spacer(),
                                          Switch(
                                              value: isIO,
                                              onChanged: (result) {
                                                // TODO logic
                                                isIO = result;
                                                setState(() {});
                                              })
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 15),
                                      decoration: BoxDecoration(
                                        color: mainGreyColorTheme2,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 129,
                                      width: 79,
                                      child: Column(
                                        children: [
                                          SubTitleText(title: lbl_MCB),
                                          Spacer(),
                                          Switch(
                                              value: isMCB,
                                              onChanged: (result) {
                                                // TODO logic
                                                isMCB = result;
                                                setState(() {});
                                              })
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 15),
                                      decoration: BoxDecoration(
                                        color: mainGreyColorTheme2,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 129,
                                      width: 79,
                                      child: Column(
                                        children: [
                                          SubTitleText(title: lbl_GCB),
                                          Spacer(),
                                          Switch(
                                              value: isGCB,
                                              onChanged: (result) {
                                                // TODO logic
                                                isGCB = result;
                                                setState(() {});
                                              })
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            infotile(
                              title: lbl_Engine,
                              value: EngineState.value.toString(),
                            ),
                            infotile(
                              title: lbl_Breaker,
                              value: BreakState.value.toString(),
                            ),
                            infotile(
                              title: lbl_Running_Hours,
                              value: RunningHours.value.toString(),
                            ),
                            infotile(
                              title: lbl_Battery,
                              value: BatteryVoltage.value.toString(),
                            ),
                            infotile(
                              title: lbl_Pressure,
                              value: OilPressure.value.toString(),
                            ),
                            infotile(
                              title: lbl_Temperature,
                              value: CoolantTemp.value.toString(),
                            ),
                            infotile(
                              title: lbl_Gas,
                              value: EngineState.value.toString(),
                            ),
                            infotile(
                              title: lbl_Load,
                              value: GeneratorLoad.value.toString(),
                            ),
                          ],
                        )
                      ]);
                    }
                  } else {
                    return Custom_Alert(
                        Title: 'Error Has Occured',
                        Description:
                            "Something Went Wrong! it seems that no generator is assigned.");
                  }
                }),
          ),
        ));
  }
}

class infotile extends StatelessWidget {
  String title, value;
  infotile({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: lightBorderColor,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontFamily: PoppinsFamily,
              fontSize: 14,
              color: mainBlackColorTheme),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(bottom: 6, top: 6, left: 16, right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: mainColorTheme, width: 1),
                color: Colors.transparent,
              ),
              child: Text(value == "" ? "0" : value,
                  style: TextStyle(
                      color: mainColorTheme,
                      fontSize: 14,
                      fontFamily: PoppinsFamily)),
            ),
          ),
        ),
      ),
    );
  }
}

class Custom_Alert extends StatelessWidget {
  String Title;
  String Description;
  Custom_Alert({required this.Title, required this.Description});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        new Text(
          Title,
          style: TextStyle(color: Color(0XFF130925)),
        ),
      ]),
      content: new Text(
        Description,
        style: TextStyle(color: Colors.purple),
      ),
      actions: <Widget>[],
    );
  }
}
