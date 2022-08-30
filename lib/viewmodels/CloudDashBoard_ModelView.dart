import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mymikano_app/models/CloudSensor_Model.dart';
import 'package:mymikano_app/services/CloudDashboard_Service.dart';

class CloudDashBoard_ModelView {
  //final String ApiEnd;
  late List<CloudSensor> cloudsensors = [];
  late CloudDashBoard_Service DashBoardService;

  Future<void> GetListCloudSensors() async {
    cloudsensors = await DashBoardService.FetchData();
  }

  CloudSensor FindSensor(String param) {
    final index =
        cloudsensors.indexWhere((element) => element.sensorID == param);
    CloudSensor sensor = cloudsensors.elementAt(index);
    return sensor;
  }

  CloudDashBoard_ModelView(/*{required this.ApiEnd}*/) {
    DashBoardService = new CloudDashBoard_Service();
  }

  CloudSensor GetEngineState() {
    //return await DashBoardService.FetchSensorData(dotenv.env['EngineState_Guid'].toString());
    return FindSensor(dotenv.env['EngineState_id'].toString());
  }

  CloudSensor GetBreakerState() {
    return FindSensor(dotenv.env['BreakerState_id'].toString());
  }

  CloudSensor GetRunningHours() {
    //return await DashBoardService.FetchSensorData(dotenv.env['RunningHours_Guid'].toString());
    return FindSensor(dotenv.env['RunningHours_id'].toString());
  }

  CloudSensor GetRPM() {
    //return await DashBoardService.FetchSensorData(dotenv.env['Rpm_Guid'].toString());
    return FindSensor(dotenv.env['Rpm_id'].toString());
  }

  CloudSensor GetOilPressure() {
    //return await DashBoardService.FetchSensorData(dotenv.env['OilPressure_Guid'].toString());
    return FindSensor(dotenv.env['OilPressure_id'].toString());
  }

  CloudSensor GetBattryVoltage() {
// return await DashBoardService.FetchSensorData(dotenv.env['BatteryVoltage_Guid'].toString());
    return FindSensor(dotenv.env['BatteryVoltage_id'].toString());
  }

  // Future<Sensor> GetGeneratorFrequency() {
  //   //return await DashBoardService.FetchSensorData(dotenv.env['GeneratorFrequency_Guid'].toString());
  //   return DashBoardService.FetchSensorData("BreakerState");
  // }

  CloudSensor GetFuelLevel() {
    //return await DashBoardService.FetchSensorData(dotenv.env['FuelLevel_Guid'].toString());
    return FindSensor(dotenv.env['FuelLevel_id'].toString());
  }

  CloudSensor GetCoolantTemp() {
    //return await DashBoardService.FetchSensorData(dotenv.env['CoolantTemp_Guid'].toString());
    return FindSensor(dotenv.env['CoolantTemp_id'].toString());
  }

  CloudSensor GetGeneratorVoltage() {
    //return await DashBoardService.FetchSensorData(dotenv.env['GeneratorVoltage_Guid'].toString());
    return FindSensor(dotenv.env['GeneratorVoltage_id'].toString());
  }

  CloudSensor GetGeneratorLoad() {
    //return await DashBoardService.FetchSensorData(dotenv.env['GeneratorLoad_Guid'].toString());
    return FindSensor(dotenv.env['GeneratorLoad_id'].toString());
  }

  CloudSensor GetControllerMode() {
    //return await DashBoardService.FetchSensorData(dotenv.env['Controller_Mode'].toString());
    return FindSensor(dotenv.env['ControllerMode_id'].toString());
  }

  CloudSensor GetMCBMode() {
    //return await DashBoardService.FetchSensorData(dotenv.env['Controller_Mode'].toString());
    // return DashBoardService.FetchSensorData("MCB");
    return FindSensor(dotenv.env['MCBMode_id'].toString());
  }

  Future<bool> SwitchControllerMode(bool status) async {
    return await DashBoardService.SwitchControllerMode(status);
  }

  Future<bool> SwitchMCBMode(bool status) async {
    return await DashBoardService.SwitchMCBMode(status);
  }

  Future<bool> SwitchOnOff(bool status) async {
    return await DashBoardService.TurnGeneratorEngineOnOff(status); 
  }
}
