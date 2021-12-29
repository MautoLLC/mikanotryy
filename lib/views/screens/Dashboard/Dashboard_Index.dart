import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymikano_app/models/Sensor_Model.dart';
import 'package:mymikano_app/models/Token_Model.dart';
import 'package:mymikano_app/viewmodels/DashBoard_ModelView.dart';
import 'Card_ImageTitleDescription.dart';
import 'Card_ImageTitleTime.dart';
import 'Card_ImageValue.dart';
import 'Custom_Alert.dart';
import 'Custom_Card_CircularGauge.dart';
import 'Row_TitleValueUnit.dart';
import 'ToggleButton_Row.dart';

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
    try{

    DashModelView = new DashBoard_ModelView();
    await DashModelView.GetUserToken();
    await DashModelView.getListGuid();
    await DashModelView.GetUnitValues();
    EngineState = DashModelView.GetEngineState();
    BreakState = DashModelView.GetBreakerState();
    RunningHours = DashModelView.GetRunningHours();
    Hours = RunningHours.value.toString();
    Minutes = RunningHours.value.toString() != "Restricted"
        ? ((double.parse(RunningHours.value.toString()) - double.parse(Hours)) *
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
    } on Exception{
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Generator',
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              bottom: PreferredSize(
                  child: Container(
                    color: Colors.orange,
                    height: 0.0,
                  ),
                  preferredSize: Size.fromHeight(0.0)),
            ),
            body: FutureBuilder<bool>(
              future: FetchData(),
              builder: (
                BuildContext context,
                AsyncSnapshot<bool> snapshot,
              ) {
                print(snapshot.connectionState);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: SpinKitCircle(
                    color: Colors.black,
                    size: 65,
                  ));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    
                    return Custom_Alert(
                        Title: 'Error Has Occured',
                        Description:
                            "Something Went Wrong!, Please Check Your Internet Connection And Wait For The Next Reload.");
                  } else if (snapshot.hasData) {
                    if(snapshot.data!){
                    return Padding(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            ToggleButton_Row(
                                status: ControllerModeStatus,
                                power: PowerStatus,
                                DashBoardModelView: DashModelView),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                if (EngineState.value != "Restricted")
                                  Expanded(
                                    child: Card_ImageTitleDescription(
                                      ImagePath: "assets/EngineState.png",
                                      Title: "Engine State",
                                      Description: EngineState.value,
                                    ),
                                    flex: 1,
                                  ),
                                if (BreakState.value != "Restricted")
                                  Expanded(
                                    child: Card_ImageTitleDescription(
                                      ImagePath: "assets/Breaker.png",
                                      Title: "Breaker State",
                                      Description: BreakState.value,
                                    ),
                                    flex: 1,
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if (Hours != "Restricted")
                              Card_ImageTitleTime(
                                ImagePath: "assets/RunningHours.png",
                                Title: "Running Hours",
                                Hours: Hours,
                                Minutes: Minutes,
                                Headerh: "Hours",
                                Headerm: "Minutes",
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            if (Rpm.value != "Restricted")
                              Custom_Card_CircularGuage(
                                  Title: 'RPM',
                                  Unit: Rpm.unit + "*100",
                                  Value: ((Rpm.value) / 100).toString()),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                if (BatteryVoltage.value.toString() !=
                                    "Restricted")
                                  Expanded(
                                    child: Card_ImageTitleDescription(
                                      ImagePath: "assets/Battery.png",
                                      Title: "Battery",
                                      Description:
                                          BatteryVoltage.value.toString() +
                                              " " +
                                              BatteryVoltage.unit.toString(),
                                    ),
                                    flex: 1,
                                  ),
                                if (OilPressure.value.toString() !=
                                    "Restricted")
                                  Expanded(
                                    child: Card_ImageValue(
                                        ImagePath: 'assets/oilIcon.png',
                                        Value: OilPressure.value.toString() +
                                            " " +
                                            OilPressure.unit.toString()),
                                    flex: 1,
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                if (CoolantTemp.value.toString() !=
                                    "Restricted")
                                  Expanded(
                                    child: Card_ImageValue(
                                      ImagePath: "assets/Temperature.png",
                                      Value: CoolantTemp.value.toString() +
                                          " " +
                                          CoolantTemp.unit.toString(),
                                    ),
                                    flex: 1,
                                  ),
                                if (FuelLevel.value.toString() != "Restricted")
                                  Expanded(
                                    child: Card_ImageValue(
                                        ImagePath: 'assets/Fuel.png',
                                        Value: FuelLevel.value.toString() +
                                            " " +
                                            FuelLevel.unit.toString()),
                                    flex: 1,
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if (GeneratorVoltage.value.toString() !=
                                "Restricted")
                              Row_TitleValueUnit(
                                Title: "Ph-N",
                                Value: GeneratorVoltage.value.toString(),
                                Unit: GeneratorVoltage.unit.toString(),
                              ),
                            if (GeneratorLoad.value.toString() != "Restricted")
                              Row_TitleValueUnit(
                                Title: "Load",
                                Value: GeneratorLoad.value.toString(),
                                Unit: GeneratorLoad.unit.toString(),
                              ),                          ],
                        )));}
                        else{
                                              return Custom_Alert(
                        Title: 'Error Has Occured',
                        Description:
                            "Something Went Wrong! it seems that no generator is assigned.");
                        }
                  } else {
                    return Custom_Alert(
                        Title: 'Empty Data',
                        Description:
                            "The Request To Get Data Was Successful But It Seems That The Data Is Empty");
                  }
                } else {
                  return Custom_Alert(
                      Title: 'Error Has Occured',
                      Description:
                          "Something Went Wrong!, ${snapshot.connectionState}");
                }
              },
            )));
  }
}
