import 'dart:async';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mikano_dash/ModelViews/DashBoard_ModelView.dart';
import 'package:mikano_dash/Models/Sensor_Model.dart';
import 'package:mikano_dash/Models/Token_Model.dart';
import 'package:mikano_dash/Models/Unit_Model.dart';
import 'package:mikano_dash/Services/DashBorad_Service.dart';
import 'package:mikano_dash/Views/Buttons_Row.dart';
import 'package:mikano_dash/Views/Custom_Alert.dart';
import 'package:mikano_dash/Views/Custom_Card.dart';
import 'package:mikano_dash/Views/Custom_CardWithFrequency.dart';
import 'package:mikano_dash/Views/Custom_Card_CircularGauge.dart';
import 'package:mikano_dash/Views/Engine_State.dart';
import 'package:mikano_dash/Views/InputOutput.dart';
import 'package:mikano_dash/Views/Sliders_Section.dart';
import 'package:mikano_dash/Views/Time_Card.dart';
import 'package:mikano_dash/Views/ToggleButton_Row.dart';
import 'package:provider/provider.dart';
import 'Time.dart';
class Dashboard_Index  extends StatefulWidget {
  @override
  _Dashboard_IndexState createState() => _Dashboard_IndexState();
}
class _Dashboard_IndexState extends State<Dashboard_Index> {
  Token UserToken;
  Timer timer;
  Sensor EngineState;
  Sensor BreakState;
  Sensor RunningHours;
  String Hours;
  String Minutes;
  Sensor Rpm;
  Sensor BatteryVoltage;
  Sensor OilPressure;
  Sensor CoolantTemp;
  Sensor FuelLevel;
  Sensor GeneratorVoltage;
  Sensor GeneratorFrequency;
  Sensor GeneratorLoad;
  Sensor ControllerMode;
  bool ControllerModeStatus;
  bool PowerStatus;
  DashBoard_ModelView DashModelView;
  //This function is to fetch the data and await rest apis //
  Future<String> FetchData() async{
    DashModelView=new DashBoard_ModelView();
    //UserToken=await DashModelView.GetUserToken();
    await DashModelView.GetUserToken();
    await DashModelView.GetUnits();
    await DashModelView.GetUnitValues();
    EngineState=DashModelView.GetEngineState();
    BreakState=DashModelView.GetBreakerState();
    RunningHours=DashModelView.GetRunningHours();
    Hours=RunningHours.value.toString().split(".")[0];
    Minutes=((double.parse(RunningHours.value.toString())-double.parse(Hours))*60).round().toString();
    Rpm=DashModelView.GetRPM();
    BatteryVoltage=DashModelView.GetBattryVoltage();
    OilPressure=DashModelView.GetOilPressure();
    CoolantTemp=DashModelView.GetCoolantTemp();
    FuelLevel=DashModelView.GetFuelLevel();
    GeneratorVoltage=DashModelView.GetGeneratorVoltage();
    GeneratorFrequency=DashModelView.GetGeneratorFrequency();
    GeneratorLoad=DashModelView.GetGeneratorLoad();
    ControllerMode=DashModelView.GetControllerMode();
    if(ControllerMode.value=="AUTO")
      ControllerModeStatus=true;
    else
      ControllerModeStatus=false;

    if (EngineState.value == "Loaded" || EngineState.value == "Running" )
    PowerStatus = true;
    else
      PowerStatus= false;

    return("We have Managed to pull all the data");
  }

 @override void initState() {
   // TODO: implement initState
   super.initState();
   FetchData();
   timer = Timer.periodic(Duration(seconds: int.parse(dotenv.env['RefreshRate_Seconds'])), (Timer t) =>  setState((){
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
          backgroundColor:Color(0XFF130925),
          appBar: AppBar(
            title:Text('Generator Dashboard',style: TextStyle(fontSize: 20.0,fontFamily: 'CG'),),
            centerTitle: true,
            backgroundColor:Color(0XFF130925),
            bottom: PreferredSize(
                child: Container(
                  color: Colors.orange,
                  height: 1.0,
                ),
                preferredSize: Size.fromHeight(1.0)),
          ),
        body:FutureBuilder<String>(
          future:FetchData(),
          builder: (
              BuildContext context,
              AsyncSnapshot<String> snapshot,
              ) {
            print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child:SpinKitWave(
                color: Colors.orange,
                size: 65,
              ));
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Custom_Alert(Title: 'Error Has Occured',Description: "Something Went Wrong!, Please Check Your Internet Connection And Wait For The Next Reload.");
              } else if (snapshot.hasData) {
                //print(UserToken);
                return Padding(
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                    child:SingleChildScrollView(
                        child:Column(
                          children: [
                            //Buttons_Row(PowerOffImage:"assets/poweroff.jpg" ,PowerOnImage:"assets/Poweron.png"),
                            ToggleButton_Row(status: ControllerModeStatus,power: PowerStatus, DashBoardModelView: DashModelView),
                            SizedBox(height: 20,),
                            Engine_State(EngineState:EngineState.value,BreakerState:BreakState.value),
                            SizedBox(height:20 ),
                            Time(Icon:"assets/chrono.jpg",hours:Hours,minutes:Minutes,headerh:'Hours',headerm:'Minutes'),
                            SizedBox(height:20 ),
                            Custom_Card_CircularGuage(Icon:'assets/generator.png',Description:'Nominal Rpm',Unit:Rpm.unit+"*100"  ,Value:((Rpm.value)/100).toString()),
                            Custom_Card(Icon:'assets/battery.jpg',Description: "Battery Voltage",Value:BatteryVoltage.value.toString(),Unit: BatteryVoltage.unit.toString()),
                            Sliders_Section(OilValue:OilPressure.value.toString(),CoolantValue:CoolantTemp.value.toString(),FuelValue: FuelLevel.value.toString()),
                            Custom_CardWithFrequency(Icon:'assets/generator.png',Description:"Ph-N [V]" ,Frequency:GeneratorFrequency.value.toString(),Unit: GeneratorVoltage.unit,Value: GeneratorVoltage.value.toString(),),
                            Custom_Card(Icon:'assets/generator.png',Description: "Load [Kw]",Value:GeneratorLoad.value.toString(),Unit: GeneratorLoad.unit.toString()),
                          ],
                        )
                    )
                );
              } else {
                return Custom_Alert(Title: 'Empty Data',Description: "The Request To Get Data Was Successful But It Seems That The Data Is Empty");
              }
            } else {
              return Custom_Alert(Title: 'Error Has Occured',Description: "Something Went Wrong!, ${snapshot.connectionState}");
            }
          },
        )
        )
      );
  }
}


