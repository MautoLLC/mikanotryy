import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mymikano_app/models/Sensor_Model.dart';
import 'package:mymikano_app/models/Token_Model.dart';
import 'package:mymikano_app/models/Unit_Model.dart';
import 'package:mymikano_app/models/Units_Model.dart';

class DashBorad_Service {
  final String UserName = dotenv.env['UserName'].toString();
  final String Password = dotenv.env['Password'].toString();
  final String Comap_Key = dotenv.env['Comap_Key'].toString();
  final String UnitsEndPoint = dotenv.env['UnitsEndPoint'].toString();
  final String AuthenticateEndPoint =
      dotenv.env['AuthenticateEndPoint'].toString();
  late Token AppToken;
  late String UnitGuid;
  Future<Token> FetchTokenForUser() async {
    http.Response response = await http.post(Uri.parse(AuthenticateEndPoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Comap-Key': Comap_Key,
        },
        body: jsonEncode(
            <String, String>{'username': UserName, 'password': Password}));
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Token.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to Fetch Token.');
    }
  }

  Future<List<Unit>> FetchUnits() async {
    var headers = {'Comap-Key': Comap_Key, 'token': AppToken.applicationToken};
    http.Response response =
        await http.get(Uri.parse(UnitsEndPoint), headers: headers);
    if (response.statusCode == 200) {
      var JsonData = jsonDecode(response.body);
      Units UnitsObj = Units.fromJson(JsonData);
      List<Unit> unitslist =
          UnitsObj.units.map((e) => Unit.fromJson(e)).toList();
      return unitslist;
    } else {
      print(response.reasonPhrase);
      return [];
    }
  }

  Future<String?> FetchUnitValues() async {
    var headers = {'Comap-Key': Comap_Key, 'token': AppToken.applicationToken};
    http.Response response = await http
        .get(Uri.parse(UnitsEndPoint + UnitGuid + '/values'), headers: headers);
    if (response.statusCode == 200) {
      var JsonData = jsonDecode(response.body);
      return response.body;
    } else {
      return (response.reasonPhrase);
      //return response.stream.bytesToString();
    }
  }

  Future<Sensor> FetchSensorData(String SensorGuid) async {
    var headers = {'Comap-Key': Comap_Key, 'token': AppToken.applicationToken};
    http.Response response = await http.get(
        Uri.parse(
            UnitsEndPoint + UnitGuid + '/values?valueGuids=' + SensorGuid),
        headers: headers);
    if (response.statusCode == 200) {
      var JsonData = jsonDecode(response.body);
      List<dynamic> list = JsonData['values'];
      Sensor sensor = Sensor.fromJson(list.elementAt(0));
      return sensor;
    } else {
      return Sensor(
          decimalPlaces: null,
          highLimit: null,
          lowLimit: null,
          name: "null",
          timeStamp: "null",
          unit: "null",
          value: null,
          valueGuid: "null");
    }
  }

  Future<String> SwitchControllerMode(bool status) async {
    String Mode;
    if (status)
      Mode = "auto";
    else
      Mode = "man";

    http.Response response = await http.post(
        Uri.parse(UnitsEndPoint + UnitGuid + '/command'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Comap-Key': Comap_Key,
          'token': AppToken.applicationToken
        },
        body: jsonEncode(
            <String, String>{"command": "changeMode", "mode": Mode}));
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return jsonDecode(response.body)['status'];
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to send command.');
    }
  }

  Future<String> TurnGeneratorOnOff(bool status) async {
    String Command;
    if (status)
      Command = "start";
    else
      Command = "stop";

    http.Response response =
        await http.post(Uri.parse(UnitsEndPoint + UnitGuid + '/command'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Comap-Key': Comap_Key,
              'token': AppToken.applicationToken
            },
            body: jsonEncode(<String, String>{
              "command": Command,
            }));
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return jsonDecode(response.body)['status'];
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to send command.');
    }
  }
}
