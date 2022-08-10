import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mymikano_app/models/CloudSensor_Model.dart';
import 'package:mymikano_app/models/ConfigurationModel.dart';
import 'package:mymikano_app/services/CloudDashboard_Service.dart';

class CloudGeneratorState extends ChangeNotifier {
  late  CloudDashBoard_Service cloudService;
  //CloudDashBoard_Service cloudService=new CloudDashBoard_Service();
  CloudSensor EngineState = CloudSensor(
      sensorID: "Error",
      sensorName: "Error",
      value: "100",
      unit: "Error",
      timeStamp: "Error");
  CloudSensor BreakState = CloudSensor(
      sensorID: "Error",
      sensorName: "Error",
      value: "100",
      unit: "Error",
      timeStamp: "Error");
  CloudSensor RunningHours = CloudSensor(
      sensorID: "Error",
      sensorName: "Error",
      value: "100",
      unit: "Error",
      timeStamp: "Error");
  late String Hours;
  late String Minutes;
  CloudSensor Rpm = CloudSensor(
      sensorID: "Error",
      sensorName: "Error",
      value: "100",
      unit: "Error",
      timeStamp: "Error");
  CloudSensor BatteryVoltage = CloudSensor(
      sensorID: "Error",
      sensorName: "Error",
      value: "100",
      unit: "Error",
      timeStamp: "Error");
  CloudSensor OilPressure = CloudSensor(
      sensorID: "Error",
      sensorName: "Error",
      value: "100",
      unit: "Error",
      timeStamp: "Error");
  CloudSensor CoolantTemp = CloudSensor(
      sensorID: "Error",
      sensorName: "Error",
      value: "100",
      unit: "Error",
      timeStamp: "Error");
  CloudSensor FuelLevel = CloudSensor(
      sensorID: "Error",
      sensorName: "Error",
      value: "100",
      unit: "Error",
      timeStamp: "Error");
  CloudSensor GeneratorVoltage = CloudSensor(
      sensorID: "Error",
      sensorName: "Error",
      value: "100",
      unit: "Error",
      timeStamp: "Error");
  CloudSensor GeneratorFrequency = CloudSensor(
      sensorID: "Error",
      sensorName: "Error",
      value: "100",
      unit: "Error",
      timeStamp: "Error");
  CloudSensor GeneratorLoad = CloudSensor(
      sensorID: "Error",
      sensorName: "Error",
      value: "100",
      unit: "Error",
      timeStamp: "Error");
  CloudSensor ControllerMode = CloudSensor(
      sensorID: "Error",
      sensorName: "Error",
      value: "100",
      unit: "Error",
      timeStamp: "Error");
  CloudSensor MCBMode = CloudSensor(
      sensorID: "Error",
      sensorName: "Error",
      value: "100",
      unit: "Error",
      timeStamp: "Error");
  CloudSensor GCBMode = CloudSensor(
      sensorID: "Error",
      sensorName: "Error",
      value: "100",
      unit: "Error",
      timeStamp: "Error");
  CloudSensor Engine = CloudSensor(
      sensorID: "Error",
      sensorName: "Error",
      value: "100",
      unit: "Error",
      timeStamp: "Error");
  bool ControllerModeStatus = false;
  bool MCBModeStatus = false;
  bool PowerStatus = false;
  bool isGCB = false;
  bool isIO = false;

  changeControllerModeStatus(value) async {
    bool isSuccess = await cloudService.SwitchControllerMode(value);
    if (isSuccess == true) {
      ControllerModeStatus = value;
      notifyListeners();
    }
  }

  changeIsIO(value) async {
    bool isSuccess = await cloudService.TurnGeneratorEngineOnOff(value);
    if (isSuccess == true) {
      isIO = value;
      notifyListeners();
    }
  }

  changeIsGCB(value) async {
    bool isSuccess = await cloudService.SwitchGCBMode(value);
    if (isSuccess == true) {
      isGCB = value;
      notifyListeners();
    }
  }

  changeMCBModeStatus(value) async {
    bool isSuccess = await cloudService.SwitchMCBMode(value);
    if (isSuccess == true) {
      MCBModeStatus = value;
      notifyListeners();
    }
  }

  Future<bool> FetchData() async {
    List<CloudSensor> cloudsensors = [];
    cloudsensors = await cloudService.FetchData();

    if (cloudsensors == []) {
      return false;
    } else {
      EngineState =
          FindSensor(cloudsensors, dotenv.env['EngineState_id'].toString());
      BreakState =
          FindSensor(cloudsensors, dotenv.env['BreakerState_id'].toString());
      RunningHours =
          FindSensor(cloudsensors, dotenv.env['RunningHours_id'].toString());
      // Hours = RunningHours.value.toString();
      // Minutes = RunningHours.value.toString() != "Restricted"
      //     ? ((double.parse(RunningHours.value.toString()) -
      //                 double.parse(Hours)) *
      //             60)
      //         .round()
      //         .toString()
      //     : "Restricted";
      Rpm = FindSensor(cloudsensors, dotenv.env['Rpm_id'].toString());
      BatteryVoltage =
          FindSensor(cloudsensors, dotenv.env['BatteryVoltage_id'].toString());
      OilPressure =
          FindSensor(cloudsensors, dotenv.env['OilPressure_id'].toString());
      CoolantTemp =
          FindSensor(cloudsensors, dotenv.env['CoolantTemp_id'].toString());
      FuelLevel =
          FindSensor(cloudsensors, dotenv.env['FuelLevel_id'].toString());
      GeneratorVoltage = FindSensor(
          cloudsensors, dotenv.env['GeneratorVoltage_id'].toString());
      //GeneratorFrequency = await DashModelView.GetGeneratorFrequency();
      GeneratorLoad =
          FindSensor(cloudsensors, dotenv.env['GeneratorLoad_id'].toString());
      ControllerMode =
          FindSensor(cloudsensors, dotenv.env['ControllerMode_id'].toString());
      MCBMode = FindSensor(cloudsensors, dotenv.env['MCBMode_id'].toString());
      GCBMode = FindSensor(cloudsensors, dotenv.env['GCB_id'].toString());
      Engine =
          FindSensor(cloudsensors, dotenv.env['EngineOnOff_id'].toString());

      //for testing purposes only//
      //MCBMode = await DashModelView.GetControllerMode();

      if (ControllerMode.value == "AUTO")
        ControllerModeStatus = true;
      else
        ControllerModeStatus = false;

      //for testing purposes only
      //MCBMode.value="1";
      if (MCBMode.value == "Close-On")
        MCBModeStatus = true;
      else
        MCBModeStatus = false;

      if (GCBMode.value == "Close-On")
        isGCB = true;
      else
        isGCB = false;

      if (Engine.value == "ON")
        isIO = true;
      else
        isIO = false;

      if (EngineState.value == "Loaded" || EngineState.value == "Running")
        PowerStatus = true;
      else
        PowerStatus = false;
      notifyListeners();
      return true;
    }
  }

  CloudSensor FindSensor(List<CloudSensor> cloudsensors, String param) {
    final index =
        cloudsensors.indexWhere((element) => element.sensorID == param);
    CloudSensor sensor = cloudsensors.elementAt(index);
    return sensor;
  }
  Future <void> ReinitiateCloudService() async {
    cloudService=new CloudDashBoard_Service();
  }
}
