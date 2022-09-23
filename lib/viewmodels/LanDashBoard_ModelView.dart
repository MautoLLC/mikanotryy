import 'package:mymikano_app/models/LanSensor_Model.dart';
import 'package:mymikano_app/services/LanDashboard_Service.dart';

class LanDashBoard_ModelView {
  //final String ApiEnd;
  late LanDashBoard_Service DashBoardService;

  LanDashBoard_ModelView(/*{required this.ApiEnd}*/) {
    DashBoardService = new LanDashBoard_Service(/*ApiEndPoint: ApiEnd*/);
  }

  Future<LANSensor> GetEngineState() {
    //return await DashBoardService.FetchSensorData(dotenv.env['EngineState_Guid'].toString());
    return DashBoardService.FetchSensorData("EngineState");
  }

  Future<LANSensor> GetBreakerState() {
    return DashBoardService.FetchSensorData("BreakerState");
  }

  Future<LANSensor> GetRunningHours() {
    //return await DashBoardService.FetchSensorData(dotenv.env['RunningHours_Guid'].toString());
    return DashBoardService.FetchSensorData("RunningHours");
  }

  Future<LANSensor> GetRPM() {
    //return await DashBoardService.FetchSensorData(dotenv.env['Rpm_Guid'].toString());
    return DashBoardService.FetchSensorData("RPM");
  }

  Future<LANSensor> GetOilPressure() {
    //return await DashBoardService.FetchSensorData(dotenv.env['OilPressure_Guid'].toString());
    return DashBoardService.FetchSensorData("OilPressure");
  }

  Future<LANSensor> GetBattryVoltage() {
// return await DashBoardService.FetchSensorData(dotenv.env['BatteryVoltage_Guid'].toString());
    return DashBoardService.FetchSensorData("BatteryVoltage");
  }

  Future<LANSensor> GetGeneratorFrequency() {
    //return await DashBoardService.FetchSensorData(dotenv.env['GeneratorFrequency_Guid'].toString());
    return DashBoardService.FetchSensorData("BreakerState");
  }

  Future<LANSensor> GetFuelLevel() {
    //return await DashBoardService.FetchSensorData(dotenv.env['FuelLevel_Guid'].toString());
    return DashBoardService.FetchSensorData("TotalFuelConsumption");
  }

  Future<LANSensor> GetCoolantTemp() {
    //return await DashBoardService.FetchSensorData(dotenv.env['CoolantTemp_Guid'].toString());
    return DashBoardService.FetchSensorData("CoolantTemp");
  }

  Future<LANSensor> GetGeneratorVoltage() {
    //return await DashBoardService.FetchSensorData(dotenv.env['GeneratorVoltage_Guid'].toString());
    return DashBoardService.FetchSensorData("OutputVoltage");
  }

  Future<LANSensor> GetGeneratorLoad() {
    //return await DashBoardService.FetchSensorData(dotenv.env['GeneratorLoad_Guid'].toString());
    return DashBoardService.FetchSensorData("Load");
  }

  Future<LANSensor> GetControllerMode() {
    //return await DashBoardService.FetchSensorData(dotenv.env['Controller_Mode'].toString());
    return DashBoardService.FetchSensorData("ControllerMode");
  }

  Future<LANSensor> GetMCBMode() {
    //return await DashBoardService.FetchSensorData(dotenv.env['Controller_Mode'].toString());
    return DashBoardService.FetchSensorData("MCB");
  }

  Future<bool> SwitchControllerMode(int status) async {
    return await DashBoardService.SwitchControllerMode(status);
  }

  Future<bool> SwitchMCBMode(bool status) async {
    return await DashBoardService.SwitchMCBMode(status); 
  }

  Future<bool> SwitchOnOff(bool status) async {
    return await DashBoardService.TurnGeneratorEngineOnOff(status);
  }
}
