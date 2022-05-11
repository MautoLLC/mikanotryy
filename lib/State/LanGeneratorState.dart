import 'package:flutter/material.dart';
import 'package:mymikano_app/models/LanSensor_Model.dart';
import 'package:mymikano_app/services/LanDashboard_Service.dart';
import 'package:mymikano_app/viewmodels/LanDashBoard_ModelView.dart';

class LanGeneratorState extends ChangeNotifier {
  LanDashBoard_Service LanService = LanDashBoard_Service();
  final Map EnState = {
    'Init': 0,
    'Ready': 1,
    'NotReady': 2,
    'Prestart': 3,
    'Cranking': 4,
    'Pause': 5,
    'Satrting': 6,
    'Running': 7,
    'Loaded': 8,
    'Softunld': 9,
    'Cooling': 10,
    'Stop': 11,
    'Shutdown': 12,
    'Ventil': 13,
    'EmergMan': 14,
    'Softload': 15,
    'WaitStop': 16,
    'SDVentil': 17
  };
  final Map BrState = {
    'Init': 0,
    'BrksOff': 1,
    'IslOper': 2,
    'MainsOper': 3,
    'ParalOper': 4,
    'RevSync': 5,
    'Synchro': 6,
    'MainsFlt': 7,
    'ValidFlt': 8,
    'MainsRet': 9,
    'MultIslOp': 10,
    'MultParOp': 11,
    'EmergMan': 12
  };
  LANSensor EngineState = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor BreakState = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor RunningHours = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  String Hours = "10";
  String Minutes = "10";
  LANSensor Rpm = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor BatteryVoltage = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor OilPressure = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor CoolantTemp = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor FuelLevel = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor GeneratorVoltage = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor GeneratorFrequency = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor GeneratorLoad = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor ControllerMode = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor MCBMode = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor GCBMode = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  LANSensor Engine = LANSensor(
      return_value: 10,
      id: "Error",
      name: "Error",
      hardware: "Error",
      connected: "Error");
  bool ControllerModeStatus = false;
  bool MCBModeStatus = false;
  bool PowerStatus = false;

  late bool MCBisAuto = MCBModeStatus;
  bool isIO = false;
  bool isGCB = false;

  changeControllerModeStatus(value) async {
    bool isSuccess = await LanService.SwitchControllerMode(value);
    if (isSuccess == true) {
      ControllerModeStatus = value;
      notifyListeners();
    }
  }

  changeIsIO(value) async {
    bool isSuccess = await LanService.TurnGeneratorEngineOnOff(value);
    if (isSuccess == true) {
      isIO = value;
      notifyListeners();
    }
  }

  changeIsGCB(value) async {
    bool isSuccess = await LanService.SwitchGCBMode(value);
    if (isSuccess == true) {
      isGCB = value;
      notifyListeners();
    }
  }

  changeMCBModeStatus(value) async {
    bool isSuccess = await LanService.SwitchMCBMode(value);
    if (isSuccess == true) {
      MCBModeStatus = value;
      notifyListeners();
    }
  }

  Future<bool> FetchData() async {
    try {
      EngineState = await LanService.FetchSensorData("EngineState");
      BreakState = await LanService.FetchSensorData("BreakerState");
      RunningHours = await LanService.FetchSensorData("RunningHours");
      Hours = RunningHours.return_value.toString();
      Minutes = RunningHours.return_value.toString() != "Restricted"
          ? ((double.parse(RunningHours.return_value.toString()) -
                      double.parse(Hours)) *
                  60)
              .round()
              .toString()
          : "Restricted";
      Rpm = await LanService.FetchSensorData("RPM");
      BatteryVoltage = await LanService.FetchSensorData("BatteryVoltage");
      OilPressure = await LanService.FetchSensorData("OilPressure");
      CoolantTemp = await LanService.FetchSensorData("CoolantTemp");
      FuelLevel = await LanService.FetchSensorData("TotalFuelConsumption");
      GeneratorVoltage = await LanService.FetchSensorData("OutputVoltage");
      GeneratorFrequency = await LanService.FetchSensorData("BreakerState");
      GeneratorLoad = await LanService.FetchSensorData("Load");
      ControllerMode = await LanService.FetchSensorData("ControllerMode");
      MCBMode = await LanService.FetchSensorData("MCB");
      GCBMode = await LanService.FetchSensorData("GCB");
      Engine = await LanService.FetchSensorData("Engine");
      if (ControllerMode.return_value == 2)
        ControllerModeStatus = true;
      else
        ControllerModeStatus = false;

      if (MCBMode.return_value == 1)
        MCBModeStatus = true;
      else
        MCBModeStatus = false;

      if (GCBMode.return_value == 1)
        isGCB = true;
      else
        isGCB = false;

      if (Engine.return_value == 1)
        isIO = true;
      else
        isIO = false;
      if (EngineState.return_value == 8 || EngineState.return_value == 7)
        PowerStatus = true;
      else
        PowerStatus = false;
      notifyListeners();
      return true;
    } on Exception {
      return false;
    }
  }
}
