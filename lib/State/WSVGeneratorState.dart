import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mymikano_app/models/Sensor_Model.dart';
import 'package:mymikano_app/models/Token_Model.dart';
import 'package:mymikano_app/models/Unit_Model.dart';
import 'package:mymikano_app/services/DashBoard_Service.dart';

class WSVGeneratorState extends ChangeNotifier {
  DashBorad_Service wsvService = DashBorad_Service();
  Token UserToken =
      Token(login: "login", type: "type", applicationToken: "applicationToken");
  Sensor EngineState = Sensor(
      name: "Restricted",
      valueGuid: "Error",
      value: 100,
      unit: "Error",
      highLimit: "Error",
      lowLimit: "Error",
      decimalPlaces: "Error",
      timeStamp: "Error");
  Sensor BreakState = Sensor(
      name: "Restricted",
      valueGuid: "Error",
      value: 100,
      unit: "Error",
      highLimit: "Error",
      lowLimit: "Error",
      decimalPlaces: "Error",
      timeStamp: "Error");
  Sensor RunningHours = Sensor(
      name: "Restricted",
      valueGuid: "Error",
      value: 100,
      unit: "Error",
      highLimit: "Error",
      lowLimit: "Error",
      decimalPlaces: "Error",
      timeStamp: "Error");
  String Hours = "100";
  String Minutes = "100";
  Sensor Rpm = Sensor(
      name: "Restricted",
      valueGuid: "Error",
      value: 100,
      unit: "Error",
      highLimit: "Error",
      lowLimit: "Error",
      decimalPlaces: "Error",
      timeStamp: "Error");
  Sensor BatteryVoltage = Sensor(
      name: "Restricted",
      valueGuid: "Error",
      value: 100,
      unit: "Error",
      highLimit: "Error",
      lowLimit: "Error",
      decimalPlaces: "Error",
      timeStamp: "Error");
  Sensor OilPressure = Sensor(
      name: "Restricted",
      valueGuid: "Error",
      value: 100,
      unit: "Error",
      highLimit: "Error",
      lowLimit: "Error",
      decimalPlaces: "Error",
      timeStamp: "Error");
  Sensor CoolantTemp = Sensor(
      name: "Restricted",
      valueGuid: "Error",
      value: 100,
      unit: "Error",
      highLimit: "Error",
      lowLimit: "Error",
      decimalPlaces: "Error",
      timeStamp: "Error");
  Sensor FuelLevel = Sensor(
      name: "Restricted",
      valueGuid: "Error",
      value: 100,
      unit: "Error",
      highLimit: "Error",
      lowLimit: "Error",
      decimalPlaces: "Error",
      timeStamp: "Error");
  Sensor GeneratorVoltage = Sensor(
      name: "Restricted",
      valueGuid: "Error",
      value: 100,
      unit: "Error",
      highLimit: "Error",
      lowLimit: "Error",
      decimalPlaces: "Error",
      timeStamp: "Error");
  Sensor GeneratorFrequency = Sensor(
      name: "Restricted",
      valueGuid: "Error",
      value: 100,
      unit: "Error",
      highLimit: "Error",
      lowLimit: "Error",
      decimalPlaces: "Error",
      timeStamp: "Error");
  Sensor GeneratorLoad = Sensor(
      name: "Restricted",
      valueGuid: "Error",
      value: 100,
      unit: "Error",
      highLimit: "Error",
      lowLimit: "Error",
      decimalPlaces: "Error",
      timeStamp: "Error");
  Sensor ControllerMode = Sensor(
      name: "Restricted",
      valueGuid: "Error",
      value: 100,
      unit: "Error",
      highLimit: "Error",
      lowLimit: "Error",
      decimalPlaces: "Error",
      timeStamp: "Error");

  bool ControllerModeStatus = false;
  bool PowerStatus = false;
  bool isIO = false;
  bool isMCB = false;
  bool isGCB = false;

  Token AppToken =
      Token(login: "login", type: "type", applicationToken: "applicationToken");
  Unit _UserUnit = Unit(name: "name", unitGuid: "unitGuid", url: "url");
  List<Sensor> _SensorsList = [];
  List<String> AllowedGUID = [];

  changeControllerModeStatus(value) async {
    // bool isSuccess = await wsvService.SwitchControllerMode(value);
    // if (isSuccess == true) {
    ControllerModeStatus = value;
    notifyListeners();
    // }
  }

  changeIsIO(value) {
    isIO = value;
    notifyListeners();
  }

  changeIsGCB(value) {
    isGCB = value;
    notifyListeners();
  }

  changeIsMCB(value) {
    isMCB = value;
    notifyListeners();
  }

  Future<bool> FetchData() async {
    try {
      await GetUserToken();
      await GetListGuid();
      await GetUnitValues();

      EngineState = GetSensor(dotenv.env['EngineState_Guid'].toString());
      BreakState = GetSensor(dotenv.env['BreakerState_Guid'].toString());
      RunningHours = GetSensor(dotenv.env['RunningHours_Guid'].toString());
      Hours = RunningHours.value.toString();
      Minutes = RunningHours.value.toString() != "Restricted"
          ? ((double.parse(RunningHours.value.toString()) -
                      double.parse(Hours)) *
                  60)
              .round()
              .toString()
          : "Restricted";
      Rpm = GetSensor(dotenv.env['Rpm_Guid'].toString());
      BatteryVoltage = GetSensor(dotenv.env['BatteryVoltage_Guid'].toString());
      OilPressure = GetSensor(dotenv.env['OilPressure_Guid'].toString());
      CoolantTemp = GetSensor(dotenv.env['CoolantTemp_Guid'].toString());
      FuelLevel = GetSensor(dotenv.env['FuelLevel_Guid'].toString());
      GeneratorVoltage =
          GetSensor(dotenv.env['GeneratorVoltage_Guid'].toString());
      GeneratorFrequency =
          GetSensor(dotenv.env['GeneratorFrequency_Guid'].toString());
      GeneratorLoad = GetSensor(dotenv.env['GeneratorLoad_Guid'].toString());
      ControllerMode = GetSensor(dotenv.env['Controller_Mode'].toString());
      if (ControllerMode.value == "AUTO")
        ControllerModeStatus = true;
      else
        ControllerModeStatus = false;

      if (EngineState.value == "Loaded" || EngineState.value == "Running")
        PowerStatus = true;
      else
        PowerStatus = false;
      notifyListeners();
      return true;
    } on Exception {
      return false;
    }
  }

  Future<void> GetListGuid() async {
    AllowedGUID = await wsvService.getListGuids();
    notifyListeners();
  }

  Future<void> GetUserToken() async {
    await wsvService.FetchTokenForUser();
    await wsvService.authenticateUser();
    notifyListeners();
  }

  Future<void> GetUnitValues() async {
    _SensorsList = await wsvService.FetchUnitValues();
    notifyListeners();
  }

  Future<void> GetUnits() async {
    List UsersUnit = await wsvService.FetchUnits();
    _UserUnit = UsersUnit.elementAt(0);
    wsvService.UnitGuid = _UserUnit.unitGuid;
    notifyListeners();
  }

  Sensor GetSensor(String SensorGuid) {
    String temp = _SensorsList.singleWhere(
        (element) =>
            AllowedGUID.contains(element.valueGuid) &&
            element.valueGuid == SensorGuid, orElse: () {
      return Sensor(
          name: "Restricted",
          valueGuid: "Error",
          value: 0.0,
          unit: "Error",
          highLimit: "Error",
          lowLimit: "Error",
          decimalPlaces: "Error",
          timeStamp: "Error");
    }).name;
    debugPrint("$temp");
    return _SensorsList.singleWhere(
        (element) =>
            AllowedGUID.contains(element.valueGuid) &&
            element.valueGuid == SensorGuid, orElse: () {
      return Sensor(
          name: "Restricted",
          valueGuid: "Error",
          value: 0.0,
          unit: "Error",
          highLimit: "Error",
          lowLimit: "Error",
          decimalPlaces: "Error",
          timeStamp: "Error");
    });
  }
}
