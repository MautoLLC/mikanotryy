import 'dart:async';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymikano_app/models/Sensor_Model.dart';
import 'package:mymikano_app/models/Token_Model.dart';
import 'package:mymikano_app/viewmodels/DashBoard_ModelView.dart';
import 'package:provider/provider.dart';
import 'Card_ImageTitleDescription.dart';
import 'Card_ImageTitleTime.dart';
import 'Card_ImageValue.dart';
import 'Custom_Alert.dart';
import 'Custom_Card_CircularGauge.dart';
import 'Row_TitleValueUnit.dart';
import 'Time.dart';
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
  Future<String> FetchData() async {
    DashModelView = new DashBoard_ModelView();
    //UserToken=await DashModelView.GetUserToken();
    await DashModelView.GetUserToken();
    await DashModelView.getListGuid();
    await DashModelView.GetUnits();
    await DashModelView.GetUnitValues();
    EngineState = DashModelView.GetEngineState();
    BreakState = DashModelView.GetBreakerState();
    RunningHours = DashModelView.GetRunningHours();
    Hours = RunningHours.value.toString().split(".")[0];
    Minutes =
        ((double.parse(RunningHours.value.toString()) - double.parse(Hours)) *
                60)
            .round()
            .toString();
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
            backgroundColor: Colors.white,
            appBar: AppBar(
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
            body: FutureBuilder<String>(
              future: FetchData(),
              builder: (
                BuildContext context,
                AsyncSnapshot<String> snapshot,
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
                    //print(UserToken);
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
                                Expanded(
                                  child: Card_ImageTitleDescription(
                                    ImagePath: "assets/EngineState.png",
                                    Title: "Engine State",
                                    Description: EngineState.value,
                                  ),
                                  flex: 1,
                                ),
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
                            Custom_Card_CircularGuage(
                                Title: 'RPM',
                                Unit: Rpm.unit + "*100",
                                Value: ((Rpm.value) / 100).toString()),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
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
                                Expanded(
                                  child: Card_ImageValue(
                                      ImagePath: 'assets/OilPressure.png',
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
                                Expanded(
                                  child: Card_ImageValue(
                                    ImagePath: "assets/Temperature.png",
                                    Value: CoolantTemp.value.toString() +
                                        " " +
                                        CoolantTemp.unit.toString(),
                                  ),
                                  flex: 1,
                                ),
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
                            Row_TitleValueUnit(
                              Title: "Ph-N",
                              Value: GeneratorVoltage.value.toString(),
                              Unit: GeneratorVoltage.unit.toString(),
                            ),
                            Row_TitleValueUnit(
                              Title: "Load",
                              Value: GeneratorLoad.value.toString(),
                              Unit: GeneratorLoad.unit.toString(),
                            ),

                            ///////////////// commented by youssef k and corresponds to the old design////////
                            //Buttons_Row(PowerOffImage:"assets/poweroff.jpg" ,PowerOnImage:"assets/Poweron.png"),
                            //SizedBox(height: 20,),
                            //Engine_State(EngineState:EngineState.value,BreakerState:BreakState.value),
                            //SizedBox(height:20 ),
                            //Time(Icon:"assets/chrono.jpg",hours:Hours,minutes:Minutes,headerh:'Hours',headerm:'Minutes'),
                            //SizedBox(height:20 ),
                            //Custom_Card_CircularGuage(Icon:'assets/generator.png',Description:'Nominal Rpm',Unit:Rpm.unit+"*100"  ,Value:((Rpm.value)/100).toString()),
                            //Custom_Card(Icon:'assets/battery.jpg',Description: "Battery Voltage",Value:BatteryVoltage.value.toString(),Unit: BatteryVoltage.unit.toString()),
                            //Sliders_Section(OilValue:OilPressure.value.toString(),CoolantValue:CoolantTemp.value.toString(),FuelValue: FuelLevel.value.toString()),
                            //Custom_CardWithFrequency(Icon:'assets/generator.png',Description:"Ph-N [V]" ,Frequency:GeneratorFrequency.value.toString(),Unit: GeneratorVoltage.unit,Value: GeneratorVoltage.value.toString(),),
                            //Custom_Card(Icon:'assets/generator.png',Description: "Load [Kw]",Value:GeneratorLoad.value.toString(),Unit: GeneratorLoad.unit.toString()),
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
