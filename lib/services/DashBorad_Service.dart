import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mymikano_app/models/Sensor_Model.dart';
import 'package:mymikano_app/models/Sensors_Model.dart';
import 'package:mymikano_app/models/Token_Model.dart';
import 'package:mymikano_app/models/Unit_Model.dart';
import 'package:mymikano_app/models/Units_Model.dart';
import 'package:nb_utils/nb_utils.dart';

import 'DioClass.dart';

class DashBorad_Service {
  final String UserName = dotenv.env['UserName'].toString();
  final String Password = dotenv.env['Password'].toString();
  final String Comap_Key = dotenv.env['Comap_Key'].toString();
  final String UnitsEndPoint = dotenv.env['UnitsEndPoint'].toString();
  final String AuthenticateEndPoint =
      dotenv.env['AuthenticateEndPoint'].toString();
  late Token AppToken;
  late String UnitGuid;
  List<String> listUnitGuids = [];
  late Dio dio;

  Future<void> PrepareCall() async {
    dio = await DioClass.getDio();
  }

  Future<void> FetchTokenForUser() async {
    await PrepareCall();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await dio.post((AuthenticateEndPoint),
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Comap-Key': Comap_Key,
        }),
        data: jsonEncode(
            <String, String>{'username': UserName, 'password': Password}));
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      AppToken = Token.fromJson((response.data));
      prefs.setString("applicationToken", AppToken.applicationToken);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to Fetch Token.');
    }
  }

  Future<void> authenticateUser() async {
    await PrepareCall();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await dio.get(
      ('http://dev.codepickles.com:8091/api/UserGenerators/User/${prefs.getString('UserID')}'),
      options: Options(headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Comap-Key': Comap_Key,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      UnitGuid = (response.data)['unitGuid'];
      print(response.data);
      print(UnitGuid);
      await prefs.setString("UnitGuid", UnitGuid);
      // return Token.fromJson((response.data));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to Fetch Token.');
    }
  }

  Future<List<String>> getListGuids() async {
    await PrepareCall();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await dio.get(
      ('http://dev.codepickles.com:8091/api/UserAllowedValues/${prefs.getString("UnitGuid")}'),
      options: Options(headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      listUnitGuids = [];
      for (var item in (response.data)) {
        listUnitGuids.add(item);
      }
      // print(listUnitGuids);
      // return Token.fromJson((response.data));
      return listUnitGuids;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to Fetch Token.');
    }
  }

  Future<List<Unit>> FetchUnits() async {
    await PrepareCall();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Comap-Key': Comap_Key,
      'token': prefs.getString("applicationToken").toString(),
      'authorization': "Bearer ${prefs.getString("accessToken")}"
    };
    var response = await dio.get(
      (UnitsEndPoint),
      options: Options(headers: headers),
    );
    if (response.statusCode == 200) {
      var JsonData = (response.data);
      Units UnitsObj = Units.fromJson(JsonData);
      List<Unit> unitslist =
          UnitsObj.units.map((e) => Unit.fromJson(e)).toList();
      return unitslist;
    } else {
      print(response.statusMessage);
      return [];
    }
  }

  Future<List<Sensor>> FetchUnitValues() async {
    await PrepareCall();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Comap-Key': Comap_Key,
      'token': prefs.getString("applicationToken").toString()
    };
    var response = await dio.get(
      (UnitsEndPoint + prefs.getString("UnitGuid").toString() + '/values'),
      options: Options(headers: headers),
    );
    if (response.statusCode == 200) {
      var JsonData = (response.data);
      Sensors SensorsObj = Sensors.fromJson(JsonData);
      List<Sensor> sensorslist =
          SensorsObj.sensors.map((e) => Sensor.fromJson(e)).toList();
      return sensorslist;
    } else {
      print(response.statusMessage);
      return [];
      //return response.stream.bytesToString();
    }
  }

  Future<Sensor> FetchSensorData(String SensorGuid) async {
    await PrepareCall();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Comap-Key': Comap_Key,
      'token': prefs.getString("applicationToken").toString()
    };
    var response = await dio.get(
      (UnitsEndPoint +
          prefs.getString("UnitGuid").toString() +
          '/values?valueGuids=' +
          SensorGuid),
      options: Options(headers: headers),
    );
    if (response.statusCode == 200) {
      var JsonData = (response.data);
      List<dynamic> list = JsonData['values'];
      Sensor sensor = Sensor.fromJson(list.elementAt(0));
      return sensor;
    } else {
      print(response.statusMessage);
      return Sensor(
          name: "name",
          valueGuid: "valueGuid",
          value: "value",
          unit: "unit",
          highLimit: "highLimit",
          lowLimit: "lowLimit",
          decimalPlaces: "decimalPlaces",
          timeStamp: "timeStamp");
      //return response.stream.bytesToString();
    }
  }

  Future<String> SwitchControllerMode(bool status) async {
    await PrepareCall();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String Mode;
    if (status)
      Mode = "auto";
    else
      Mode = "man";

    var response = await dio.post(
        (UnitsEndPoint + prefs.getString("UnitGuid").toString() + '/command'),
        options: Options(headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Comap-Key': Comap_Key,
          'token': prefs.getString("applicationToken").toString()
        }),
        data: jsonEncode(
            <String, String>{"command": "changeMode", "mode": Mode}));
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return (response.data)['status'];
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to send command.');
    }
  }

  Future<String> TurnGeneratorOnOff(bool status) async {
    await PrepareCall();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String Command;
    if (status)
      Command = "start";
    else
      Command = "stop";

    var response = await dio.post(
        (UnitsEndPoint + prefs.getString("UnitGuid").toString() + '/command'),
        options: Options(headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Comap-Key': Comap_Key,
          'token': prefs.getString("applicationToken").toString()
        }),
        data: jsonEncode(<String, String>{
          "command": Command,
        }));
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return (response.data)['status'];
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to send command.');
    }
  }
}
