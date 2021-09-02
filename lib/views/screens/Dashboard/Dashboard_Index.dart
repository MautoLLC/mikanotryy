import 'dart:async';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymikano_app/models/Sensor_Model.dart';
import 'package:mymikano_app/models/Token_Model.dart';
import 'package:mymikano_app/viewmodels/DashBoard_ModelView.dart';
import 'package:mymikano_app/views/screens/Dashboard/Custom_Alert.dart';
import 'package:mymikano_app/views/screens/Dashboard/Custom_Card.dart';
import 'package:mymikano_app/views/screens/Dashboard/Custom_CardWithFrequency.dart';
import 'package:mymikano_app/views/screens/Dashboard/Custom_Card_CircularGauge.dart';
import 'package:mymikano_app/views/screens/Dashboard/Engine_State.dart';
import 'package:mymikano_app/views/screens/Dashboard/Sliders_Section.dart';
import 'package:mymikano_app/views/screens/Dashboard/ToggleButton_Row.dart';
import 'package:provider/provider.dart';
import 'Time.dart';

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
  //required this function is to fetch the data and await rest apis //
  Future<String> FetchData() async {
    DashModelView = new DashBoard_ModelView();
    //UserToken=await DashModelView.GetUserToken();
    await DashModelView.GetUserToken();
    await DashModelView.GetUnits();
    EngineState = (await DashModelView.GetEngineState())!;
    BreakState = (await DashModelView.GetBreakerState())!;
    RunningHours = (await DashModelView.GetRunningHours())!;
    Hours = RunningHours.value.toString().split(".")[0];
    Minutes =
        ((double.parse(RunningHours.value.toString()) - double.parse(Hours)) *
                60)
            .round()
            .toString();
    Rpm = (await DashModelView.GetRPM())!;
    BatteryVoltage = (await DashModelView.GetBattryVoltage())!;
    OilPressure = (await DashModelView.GetOilPressure())!;
    CoolantTemp = (await DashModelView.GetCoolantTemp())!;
    FuelLevel = (await DashModelView.GetFuelLevel())!;
    GeneratorVoltage = (await DashModelView.GetGeneratorVoltage())!;
    GeneratorFrequency = (await DashModelView.GetGeneratorFrequency())!;
    GeneratorLoad = (await DashModelView.GetGeneratorLoad())!;
    ControllerMode = (await DashModelView.GetControllerMode())!;
    if (ControllerMode.value == "AUTO")
      ControllerModeStatus = true;
    else
      ControllerModeStatus = false;

    if (EngineState.value == "Loaded" || EngineState.value == "Running")
      PowerStatus = true;
    else
      PowerStatus = false;

    return ("We have Managed to pull all the data");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchData();
    timer = Timer.periodic(
        Duration(
            seconds: int.parse(dotenv.env['RefreshRate_Seconds'].toString())),
        (Timer t) => setState(() {
              // change state according to result of request
            }));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0XFF130925),
            appBar: AppBar(
              title: Text(
                'Generator Dashboard',
                style: TextStyle(fontSize: 20.0, fontFamily: 'CG'),
              ),
              centerTitle: true,
              backgroundColor: Color(0XFF130925),
              bottom: PreferredSize(
                  child: Container(
                    color: Colors.orange,
                    height: 1.0,
                  ),
                  preferredSize: Size.fromHeight(1.0)),
            ),
            body: FutureBuilder<String>(
              future: FetchData(),
              builder: (
                BuildContext context,
                AsyncSnapshot<String> snapshot,
              ) {
                print(snapshot.connectionState);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: SpinKitWave(
                    color: Colors.orange,
                    size: 65,
                  ));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Custom_Alert(
                        Title: 'Error Has Occured',
                        Description:
                            "Something Went Wrong!, Please Check Your Internet Connection And Wait For The Next Reload.");
                  } else if (snapshot.hasData) {
                    //print(UserToken);
                    return Padding(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            //Buttons_Row(PowerOffImage:"assets/poweroff.jpg" ,PowerOnImage:"assets/Poweron.png"),
                            ToggleButton_Row(
                                status: ControllerModeStatus,
                                power: PowerStatus,
                                DashBoardModelView: DashModelView),
                            SizedBox(
                              height: 20,
                            ),
                            Engine_State(
                                EngineState: EngineState.value,
                                BreakerState: BreakState.value),
                            SizedBox(height: 20),
                            Time(
                                Icon: "assets/chrono.jpg",
                                hours: Hours,
                                minutes: Minutes,
                                headerh: 'Hours',
                                headerm: 'Minutes'),
                            SizedBox(height: 20),
                            Custom_Card_CircularGuage(
                                Icon: 'assets/generator.png',
                                Description: 'Nominal Rpm',
                                Unit: Rpm.unit + "*100",
                                Value: ((Rpm.value) / 100).toString()),
                            Custom_Card(
                                Icon: 'assets/battery.jpg',
                                Description: "Battery Voltage",
                                Value: BatteryVoltage.value.toString(),
                                Unit: BatteryVoltage.unit.toString()),
                            Sliders_Section(
                                OilValue: OilPressure.value.toString(),
                                CoolantValue: CoolantTemp.value.toString(),
                                FuelValue: FuelLevel.value.toString()),
                            Custom_CardWithFrequency(
                              Icon: 'assets/generator.png',
                              Description: "Ph-N [V]",
                              Frequency: GeneratorFrequency.value.toString(),
                              Unit: GeneratorVoltage.unit,
                              Value: GeneratorVoltage.value.toString(),
                            ),
                            Custom_Card(
                                Icon: 'assets/generator.png',
                                Description: "Load [Kw]",
                                Value: GeneratorLoad.value.toString(),
                                Unit: GeneratorLoad.unit.toString()),
                          ],
                        )));
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
