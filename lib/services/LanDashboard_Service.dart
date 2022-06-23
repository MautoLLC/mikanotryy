import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mymikano_app/models/LanSensor_Model.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';

class LanDashBoard_Service {
  //final String ApiEndPoint;
  String apiLanEndpoint = "http://" + lanESPUrl;
  LanDashBoard_Service(/*{required this.ApiEndPoint}*/);
  Future<LANSensor> FetchSensorData(String param) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiLanEndpoint = await prefs.getString(prefs_ApiLanEndpoint)!;

    final response =
        await http.get(Uri.parse(apiLanEndpoint + '/getValue?params=' + param));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      LANSensor sensor = LANSensor.fromJson(data);
      return sensor;
    } else {
      debugPrint(response.toString());
      return LANSensor(
          return_value: 0,
          id: "id",
          name: "name",
          hardware: "hardware",
          connected: "connected");
    }
  }

  Future<bool> SwitchControllerMode(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiLanEndpoint = await prefs.getString(prefs_ApiLanEndpoint)!;

    int Mode;
    if (status)
      Mode = 2;
    else
      Mode = 1;

    bool isSuccess = false;

    final response = await http.get(Uri.parse(
        apiLanEndpoint + '/setControllerMode?params=' + Mode.toString()));
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      isSuccess = true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to send command.');
    }
    return isSuccess;
  }

  Future<bool> SwitchMCBMode(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiLanEndpoint = await prefs.getString(prefs_ApiLanEndpoint)!;
    int Mode;
    if (status)
      Mode = 1;
    else
      Mode = 0;

    bool isSuccess = false;
    final response = await http.get(
        Uri.parse(apiLanEndpoint + '/setMCBMode?params=' + Mode.toString()));
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      isSuccess = true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to send command.');
    }

    return isSuccess;
  }

  Future<bool> SwitchGCBMode(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiLanEndpoint = await prefs.getString(prefs_ApiLanEndpoint)!;
    int Mode;
    if (status)
      Mode = 0;
    else
      Mode = 1;

    bool isSuccess = false;
    final response = await http.get(
        Uri.parse(apiLanEndpoint + '/setGCBMode?params=' + Mode.toString()));
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      isSuccess = true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to send command.');
    }

    return isSuccess;
  }

  Future<bool> TurnGeneratorEngineOnOff(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiLanEndpoint = await prefs.getString(prefs_ApiLanEndpoint)!;
    int Command;
    if (status)
      Command = 1;
    else
      Command = 0;
    bool isSuccess = false;
    final response = await http.get(Uri.parse(
        apiLanEndpoint + '/setEngineMode?params=' + Command.toString()));
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      isSuccess = true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to send command.');
    }
    return isSuccess;
  }
}
