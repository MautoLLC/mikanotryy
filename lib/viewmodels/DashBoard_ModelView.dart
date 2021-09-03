

import 'dart:ffi';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mikano_dash/Models/Sensor_Model.dart';
import 'package:mikano_dash/Models/Token_Model.dart';
import 'package:mikano_dash/Models/Unit_Model.dart';
import 'package:mikano_dash/Services/DashBorad_Service.dart';


class DashBoard_ModelView{
  DashBorad_Service DashBoardService=new DashBorad_Service();
  Token AppToken;
  Unit _UserUnit;
  List<Sensor> _SensorsList;

Future<void> GetUserToken() async{
   DashBoardService.AppToken= await DashBoardService.FetchTokenForUser();
  }
  Future<void> GetUnits() async{
    List<Unit> UsersUnit= await DashBoardService.FetchUnits();
    _UserUnit=UsersUnit.elementAt(0);
    DashBoardService.UnitGuid=_UserUnit.unitGuid;

  }
  Future<Void> GetUnitValues() async{
  _SensorsList= await DashBoardService.FetchUnitValues();
  }

  Sensor GetEngineState() {
    //return await DashBoardService.FetchSensorData(dotenv.env['EngineState_Guid']);
    return  GetSensor(dotenv.env['EngineState_Guid']);

  }

Sensor GetBreakerState() {
  //return await DashBoardService.FetchSensorData(dotenv.env['BreakerState_Guid']);
  return GetSensor(dotenv.env['BreakerState_Guid']);


}
Sensor GetRunningHours(){
  //return await DashBoardService.FetchSensorData(dotenv.env['RunningHours_Guid']);
  return  GetSensor(dotenv.env['RunningHours_Guid']);


}
Sensor GetRPM() {
  //return await DashBoardService.FetchSensorData(dotenv.env['Rpm_Guid']);
  return  GetSensor(dotenv.env['Rpm_Guid']);

}
Sensor GetOilPressure(){
  //return await DashBoardService.FetchSensorData(dotenv.env['OilPressure_Guid']);
  return  GetSensor(dotenv.env['OilPressure_Guid']);

}

Sensor GetBattryVoltage(){
// return await DashBoardService.FetchSensorData(dotenv.env['BatteryVoltage_Guid']);
  return  GetSensor(dotenv.env['BatteryVoltage_Guid']);


}

Sensor GetGeneratorFrequency(){
  //return await DashBoardService.FetchSensorData(dotenv.env['GeneratorFrequency_Guid']);
  return  GetSensor(dotenv.env['GeneratorFrequency_Guid']);


}

Sensor GetFuelLevel(){
  //return await DashBoardService.FetchSensorData(dotenv.env['FuelLevel_Guid']);
  return  GetSensor(dotenv.env['FuelLevel_Guid']);


}
Sensor GetCoolantTemp(){
  //return await DashBoardService.FetchSensorData(dotenv.env['CoolantTemp_Guid']);
  return  GetSensor(dotenv.env['CoolantTemp_Guid']);


}

Sensor GetGeneratorVoltage(){
  //return await DashBoardService.FetchSensorData(dotenv.env['GeneratorVoltage_Guid']);
  return  GetSensor(dotenv.env['GeneratorVoltage_Guid']);


}
Sensor GetGeneratorLoad(){
  //return await DashBoardService.FetchSensorData(dotenv.env['GeneratorLoad_Guid']);
  return  GetSensor(dotenv.env['GeneratorLoad_Guid']);


}

Sensor GetControllerMode(){
  //return await DashBoardService.FetchSensorData(dotenv.env['Controller_Mode']);
  return  GetSensor(dotenv.env['Controller_Mode']);


}

Future<String> SwitchControllerMode(bool status) async{
  return await DashBoardService.SwitchControllerMode(status);

}

  Future<String> SwitchOnOff(bool status) async{
    return await DashBoardService.TurnGeneratorOnOff(status);

  }

  Sensor GetSensor(String SensorGuid){
  return _SensorsList.singleWhere((element) => element.valueGuid==SensorGuid);
  }


}