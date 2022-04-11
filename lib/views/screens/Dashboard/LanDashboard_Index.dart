import 'dart:async';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymikano_app/State/ApiConfigurationState.dart';
import 'package:mymikano_app/models/LanSensor_Model.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/viewmodels/LanDashBoard_ModelView.dart';
import 'package:mymikano_app/views/screens/Dashboard/ApiConfigurationPage.dart';
import 'package:mymikano_app/views/widgets/GaugeWidget.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class LanDashboard_Index extends StatefulWidget {
  // final String ApiEndPoint;
  final int RefreshRate;
  LanDashboard_Index(
      {Key? key, /*required this.ApiEndPoint,*/ required this.RefreshRate})
      : super(key: key);

  @override
  _LanDashboard_IndexState createState() => _LanDashboard_IndexState();
}

class _LanDashboard_IndexState extends State<LanDashboard_Index> {
  final Map EnState = {
    'Init': 0,
    'Ready': 1,
    'NotReady': 2,
    'Prestart': 3,
    'Cranking': 4,
    'Pause': 5,
    'Satrting': 6,
    'Running': 7,
    'Loaded': 8,
    'Softunld': 9,
    'Cooling': 10,
    'Stop': 11,
    'Shutdown': 12,
    'Ventil': 13,
    'EmergMan': 14,
    'Softload': 15,
    'WaitStop': 16,
    'SDVentil': 17
  };
  final Map BrState = {
    'Init': 0,
    'BrksOff': 1,
    'IslOper': 2,
    'MainsOper': 3,
    'ParalOper': 4,
    'RevSync': 5,
    'Synchro': 6,
    'MainsFlt': 7,
    'ValidFlt': 8,
    'MainsRet': 9,
    'MultIslOp': 10,
    'MultParOp': 11,
    'EmergMan': 12
  };
  late Timer timer;
  LANSensor EngineState = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor BreakState = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor RunningHours = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  late String Hours;
  late String Minutes;
  LANSensor Rpm = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor BatteryVoltage = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor OilPressure = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor CoolantTemp = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor FuelLevel = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor GeneratorVoltage = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor GeneratorFrequency = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor GeneratorLoad = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor ControllerMode = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor MCBMode = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  bool ControllerModeStatus = false;
  bool MCBModeStatus = false;
  bool PowerStatus = false;

  //This function is to fetch the data and await rest apis //
  Future<bool> FetchData() async {
    try {
      LanDashBoard_ModelView DashModelView =
          new LanDashBoard_ModelView(/*ApiEnd: this.widget.ApiEndPoint*/);
      EngineState = await DashModelView.GetEngineState();
      BreakState = await DashModelView.GetBreakerState();
      RunningHours = await DashModelView.GetRunningHours();
      Hours = RunningHours.return_value.toString();
      Minutes = RunningHours.return_value.toString() != "Restricted"
          ? ((double.parse(RunningHours.return_value.toString()) -
                      double.parse(Hours)) *
                  60)
              .round()
              .toString()
          : "Restricted";
      Rpm = await DashModelView.GetRPM();
      BatteryVoltage = await DashModelView.GetBattryVoltage();
      OilPressure = await DashModelView.GetOilPressure();
      CoolantTemp = await DashModelView.GetCoolantTemp();
      FuelLevel = await DashModelView.GetFuelLevel();
      GeneratorVoltage = await DashModelView.GetGeneratorVoltage();
      GeneratorFrequency = await DashModelView.GetGeneratorFrequency();
      GeneratorLoad = await DashModelView.GetGeneratorLoad();
      ControllerMode = await DashModelView.GetControllerMode();
      MCBMode = await DashModelView.GetMCBMode();
      if (ControllerMode.return_value == 2)
        ControllerModeStatus = true;
      else
        ControllerModeStatus = false;

      if (MCBMode.return_value == 1)
        MCBModeStatus = true;
      else
        MCBModeStatus = false;

      if (EngineState.return_value == 8 || EngineState.return_value == 7)
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
    FetchData();
    timer = Timer.periodic(
        Duration(seconds: this.widget.RefreshRate),
        (Timer t) => setState(() {
              // change state according to result of request
            }));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  late bool isAuto = ControllerModeStatus;
  late bool MCBisAuto = MCBModeStatus;
  late bool isIO = false;
  late bool isGCB = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiConfigurationState>(
        builder: (context, value, child) => Scaffold(
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
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
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
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ApiConfigurationPage()));
                                    },
                                    icon: Icon(Icons.settings)),

                                IconButton(
                                    onPressed: () {
                                      value.resetPreferences();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ApiConfigurationPage()));
                                    },
                                    icon: Icon(Icons.refresh)),
                                // GestureDetector(
                                //     onTap: () {
                                //       Navigator.of(context).push(MaterialPageRoute(
                                //           builder: (context) =>
                                //               GeneratorAlertsPage()));
                                //     },
                                //     child: commonCacheImageWidget(ic_error, 22))
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
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 4.0, 8.0, 4.0),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: GaugeWidget(
                                            title: lbl_RPM,
                                            value: ((Rpm.return_value) / 100))),
                                    SizedBox(height: 10),
                                    Container(
                                        height: 160,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          color: mainGreyColorTheme2,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: GaugeWidget(
                                            title: lbl_Actual_Power,
                                            value: ((GeneratorLoad.return_value)
                                                .toDouble()),
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
                                                isAuto ? lbl_Auto : lbl_Manual,
                                                style: TextStyle(
                                                    fontFamily: PoppinsFamily,
                                                    fontSize: 14,
                                                    color: mainGreyColorTheme),
                                              ),
                                              Spacer(),
                                              Switch(
                                                  value: isAuto,
                                                  onChanged: (result) {
                                                    // TODO logic
                                                    isAuto = result;
                                                    setState(() {
                                                      LanDashBoard_ModelView m =
                                                          new LanDashBoard_ModelView(
                                                              /*ApiEnd: this
                                                              .widget
                                                              .ApiEndPoint*/
                                                              );
                                                      m.SwitchControllerMode(
                                                          result);
                                                    });
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          height: 129,
                                          width: 79,
                                          child: Column(
                                            children: [
                                              SubTitleText(title: lbl_MCB),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  MCBisAuto ? 'A' : 'M',
                                                  style: TextStyle(
                                                      fontFamily: PoppinsFamily,
                                                      fontSize: 14,
                                                      color:
                                                          mainGreyColorTheme),
                                                ),
                                                Spacer(),
                                                Switch(
                                                    value: MCBisAuto,
                                                    onChanged: (result) {
                                                      // TODO logic
                                                      MCBisAuto = result;
                                                      setState(() {
                                                        LanDashBoard_ModelView
                                                            m =
                                                            new LanDashBoard_ModelView(
                                                                /* ApiEnd: this
                                                                .widget
                                                                .ApiEndPoint*/
                                                                );
                                                        m.SwitchMCBMode(result);
                                                      });
                                                    })
                                              ]),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                  value: EnState.keys
                                      .elementAt(EngineState.return_value)
                                      .toString(),
                                ),
                                infotile(
                                  title: lbl_Breaker,
                                  value: BrState.keys
                                      .elementAt(BreakState.return_value)
                                      .toString(),
                                ),
                                infotile(
                                  title: lbl_Running_Hours,
                                  value: RunningHours.return_value.toString(),
                                ),
                                infotile(
                                  title: lbl_Battery,
                                  value: ((BatteryVoltage.return_value
                                              .toDouble()) /
                                          10)
                                      .toString(),
                                ),
                                infotile(
                                  title: lbl_Pressure,
                                  value:
                                      ((OilPressure.return_value.toDouble()) /
                                              10)
                                          .toString(),
                                ),
                                infotile(
                                  title: lbl_Temperature,
                                  value: CoolantTemp.return_value.toString(),
                                ),
                                infotile(
                                  title: lbl_Gas,
                                  value: EngineState.return_value.toString(),
                                ),
                                infotile(
                                  title: lbl_Load,
                                  value: GeneratorLoad.return_value.toString(),
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
            )));
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
