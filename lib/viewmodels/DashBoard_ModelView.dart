import 'dart:ffi';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mymikano_app/models/Sensor_Model.dart';
import 'package:mymikano_app/models/Token_Model.dart';
import 'package:mymikano_app/models/Unit_Model.dart';
import 'package:mymikano_app/services/DashBorad_Service.dart';

class DashBoard_ModelView {
  DashBorad_Service DashBoardService = new DashBorad_Service();
  late Token AppToken;
  late Unit _UserUnit;
  late List<Sensor> _SensorsList;

  Future<void> GetUserToken() async {
    DashBoardService.AppToken = await DashBoardService.FetchTokenForUser();
    await DashBoardService.authenticateUser();
  }

  Future<void> getListGuid() async {
    await DashBoardService.getListGuids();
  }

  Future<void> GetUnits() async {
    List UsersUnit = await DashBoardService.FetchUnits();
    _UserUnit = UsersUnit.elementAt(0);
    DashBoardService.UnitGuid = _UserUnit.unitGuid;
  }

  Future<void> GetUnitValues() async {
    _SensorsList = await DashBoardService.FetchUnitValues();
  }

  Sensor GetEngineState() {
    //return await DashBoardService.FetchSensorData(dotenv.env['EngineState_Guid'].toString());
    return GetSensor(dotenv.env['EngineState_Guid'].toString());
  }

  Sensor GetBreakerState() {
    //return await DashBoardService.FetchSensorData(dotenv.env['BreakerState_Guid'].toString());
    return GetSensor(dotenv.env['BreakerState_Guid'].toString());
  }

  Sensor GetRunningHours() {
    //return await DashBoardService.FetchSensorData(dotenv.env['RunningHours_Guid'].toString());
    return GetSensor(dotenv.env['RunningHours_Guid'].toString());
  }

  Sensor GetRPM() {
    //return await DashBoardService.FetchSensorData(dotenv.env['Rpm_Guid'].toString());
    return GetSensor(dotenv.env['Rpm_Guid'].toString());
  }

  Sensor GetOilPressure() {
    //return await DashBoardService.FetchSensorData(dotenv.env['OilPressure_Guid'].toString());
    return GetSensor(dotenv.env['OilPressure_Guid'].toString());
  }

  Sensor GetBattryVoltage() {
// return await DashBoardService.FetchSensorData(dotenv.env['BatteryVoltage_Guid'].toString());
    return GetSensor(dotenv.env['BatteryVoltage_Guid'].toString());
  }

  Sensor GetGeneratorFrequency() {
    //return await DashBoardService.FetchSensorData(dotenv.env['GeneratorFrequency_Guid'].toString());
    return GetSensor(dotenv.env['GeneratorFrequency_Guid'].toString());
  }

  Sensor GetFuelLevel() {
    //return await DashBoardService.FetchSensorData(dotenv.env['FuelLevel_Guid'].toString());
    return GetSensor(dotenv.env['FuelLevel_Guid'].toString());
  }

  Sensor GetCoolantTemp() {
    //return await DashBoardService.FetchSensorData(dotenv.env['CoolantTemp_Guid'].toString());
    return GetSensor(dotenv.env['CoolantTemp_Guid'].toString());
  }

  Sensor GetGeneratorVoltage() {
    //return await DashBoardService.FetchSensorData(dotenv.env['GeneratorVoltage_Guid'].toString());
    return GetSensor(dotenv.env['GeneratorVoltage_Guid'].toString());
  }

  Sensor GetGeneratorLoad() {
    //return await DashBoardService.FetchSensorData(dotenv.env['GeneratorLoad_Guid'].toString());
    return GetSensor(dotenv.env['GeneratorLoad_Guid'].toString());
  }

  Sensor GetControllerMode() {
    //return await DashBoardService.FetchSensorData(dotenv.env['Controller_Mode'].toString());
    return GetSensor(dotenv.env['Controller_Mode'].toString());
  }

  Future<String> SwitchControllerMode(bool status) async {
    return await DashBoardService.SwitchControllerMode(status);
  }

  Future<String> SwitchOnOff(bool status) async {
    return await DashBoardService.TurnGeneratorOnOff(status);
  }

  Sensor GetSensor(String SensorGuid) {
    print(_SensorsList.singleWhere((element) => element.valueGuid == SensorGuid)
        .name);
    return _SensorsList.singleWhere(
        (element) => element.valueGuid == SensorGuid);
  }
}
