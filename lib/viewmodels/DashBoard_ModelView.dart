import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mymikano_app/models/Sensor_Model.dart';
import 'package:mymikano_app/models/Token_Model.dart';
import 'package:mymikano_app/models/Unit_Model.dart';
import 'package:mymikano_app/services/DashBorad_Service.dart';

class DashBoard_ModelView {
  DashBorad_Service DashBoardService = new DashBorad_Service();
  late Token AppToken;
  late Unit _UserUnit;

  Future<void> GetUserToken() async {
    DashBoardService.AppToken = await DashBoardService.FetchTokenForUser();
  }

  Future<void> GetUnits() async {
    List<Unit> UsersUnit = await DashBoardService.FetchUnits();
    _UserUnit = UsersUnit.elementAt(0);
    DashBoardService.UnitGuid = _UserUnit.unitGuid;
  }

  Future<String?> GetUnitValues() async {
    return await DashBoardService.FetchUnitValues();
  }

  Future<Sensor?> GetEngineState() async {
    return await DashBoardService.FetchSensorData(
        dotenv.env['EngineState_Guid'].toString());
  }

  Future<Sensor?> GetBreakerState() async {
    return await DashBoardService.FetchSensorData(
        dotenv.env['BreakerState_Guid'].toString());
  }

  Future<Sensor?> GetRunningHours() async {
    return await DashBoardService.FetchSensorData(
        dotenv.env['RunningHours_Guid'].toString());
  }

  Future<Sensor?> GetRPM() async {
    return await DashBoardService.FetchSensorData(
        dotenv.env['Rpm_Guid'].toString());
  }

  Future<Sensor?> GetOilPressure() async {
    return await DashBoardService.FetchSensorData(
        dotenv.env['OilPressure_Guid'].toString());
  }

  Future<Sensor?> GetBattryVoltage() async {
    return await DashBoardService.FetchSensorData(
        dotenv.env['BatteryVoltage_Guid'].toString());
  }

  Future<Sensor?> GetGeneratorFrequency() async {
    return await DashBoardService.FetchSensorData(
        dotenv.env['GeneratorFrequency_Guid'].toString());
  }

  Future<Sensor?> GetFuelLevel() async {
    return await DashBoardService.FetchSensorData(
        dotenv.env['FuelLevel_Guid'].toString());
  }

  Future<Sensor?> GetCoolantTemp() async {
    return await DashBoardService.FetchSensorData(
        dotenv.env['CoolantTemp_Guid'].toString());
  }

  Future<Sensor?> GetGeneratorVoltage() async {
    return await DashBoardService.FetchSensorData(
        dotenv.env['GeneratorVoltage_Guid'].toString());
  }

  Future<Sensor?> GetGeneratorLoad() async {
    return await DashBoardService.FetchSensorData(
        dotenv.env['GeneratorLoad_Guid'].toString());
  }

  Future<Sensor?> GetControllerMode() async {
    return await DashBoardService.FetchSensorData(
        dotenv.env['Controller_Mode'].toString());
  }

  Future<String> SwitchControllerMode(bool status) async {
    return await DashBoardService.SwitchControllerMode(status);
  }

  Future<String> SwitchOnOff(bool status) async {
    return await DashBoardService.TurnGeneratorOnOff(status);
  }
}
