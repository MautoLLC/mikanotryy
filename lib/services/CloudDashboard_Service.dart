import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mymikano_app/models/CloudSensor_Model.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:nb_utils/nb_utils.dart';

class CloudDashBoard_Service {
  //final String ApiEndPoint;
  String GeneratorID = "";
  late List<CloudSensor> cloudsensors = [];

  Future<List<CloudSensor>> FetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cloudUsername = prefs.getString(prefs_CloudUsername)!;
    String cloudPassword = prefs.getString(prefs_CloudPassword)!;
    GeneratorID = prefs.getString(prefs_GeneratorId)!;

    final responseAuth = await http.post(Uri.parse(cloudIotMautoAuthUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': cloudUsername,
          'password': cloudPassword,
        }));

    final token = jsonDecode((responseAuth.body))['token'];

    final response = await http.get(
        Uri.parse(/*ApiEndPoint + GeneratorID*/ cloudIotMautoSensorsUrl +
            GeneratorID),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      cloudsensors =
          (data['values'] as List).map((s) => CloudSensor.fromJson(s)).toList();
      return cloudsensors;
    } else {
      print(response);
      List<CloudSensor> emptylist = [];
      return emptylist;
    }
  }

  Future<bool> SwitchControllerMode(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cloudUsername = prefs.getString(prefs_CloudUsername)!;
    String cloudPassword = prefs.getString(prefs_CloudPassword)!;
    GeneratorID = prefs.getString(prefs_GeneratorId)!;
    String Mode;
    bool isSuccess = false;

    if (status)
      Mode = "AUTO";
    else
      Mode = "MAN";

    final responseAuth = await http.post(Uri.parse(cloudIotMautoAuthUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': cloudUsername,
          'password': cloudPassword,
        }));
    final token = jsonDecode((responseAuth.body))['token'];

    final response = await http.post(
      Uri.parse(cloudIotMautoSensorsUrl + GeneratorID),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token.toString()
      },
      body: jsonEncode([
        <String, String>{
          'generatorSensorID': dotenv.env['ControllerMode_id'].toString(),
          'value': Mode.toString(),
          //'timeStamp':DateTime.now().toString()
          'timeStamp': DateTime.now().toIso8601String()
        }
      ]),
    );

    if (response.statusCode == 200) {
      isSuccess = true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to update sensor');
    }
    return isSuccess;
  }

  Future<bool> SwitchMCBMode(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cloudUsername = prefs.getString(prefs_CloudUsername)!;
    String cloudPassword = prefs.getString(prefs_CloudPassword)!;
    GeneratorID = prefs.getString(prefs_GeneratorId)!;
    String Mode;
    bool isSuccess = false;

    if (status)
      Mode = "Close-On";
    else
      Mode = "Close-Off";
    final responseAuth = await http.post(Uri.parse(cloudIotMautoAuthUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': cloudUsername,
          'password': cloudPassword,
        }));
    final token = jsonDecode((responseAuth.body))['token'];

    final response = await http.post(
      Uri.parse(cloudIotMautoSensorsUrl + GeneratorID),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token.toString()
      },
      body: jsonEncode([
        <String, String>{
          'generatorSensorID': dotenv.env['MCBMode_id'].toString(),
          'value': Mode.toString(),
          //'timeStamp':DateTime.now().toString()
          'timeStamp': DateTime.now().toIso8601String()
        }
      ]),
    );

    if (response.statusCode == 200) {
      isSuccess = true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to update sensor');
    }
    return isSuccess;
  }

  Future<bool> SwitchGCBMode(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cloudUsername = prefs.getString(prefs_CloudUsername)!;
    String cloudPassword = prefs.getString(prefs_CloudPassword)!;
    GeneratorID = prefs.getString(prefs_GeneratorId)!;
    String Mode;
    bool isSuccess = false;

    if (status)
      Mode = "Close-On";
    else
      Mode = "Close-Off";
    final responseAuth = await http.post(Uri.parse(cloudIotMautoAuthUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': cloudUsername,
          'password': cloudPassword,
        }));
    final token = jsonDecode((responseAuth.body))['token'];

    final response = await http.post(
      Uri.parse(cloudIotMautoSensorsUrl + GeneratorID),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token.toString()
      },
      body: jsonEncode([
        <String, String>{
          'generatorSensorID': dotenv.env['GCB_id'].toString(),
          'value': Mode.toString(),
          //'timeStamp':DateTime.now().toString()
          'timeStamp': DateTime.now().toIso8601String()
        }
      ]),
    );

    if (response.statusCode == 200) {
      isSuccess = true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to update sensor');
    }
    return isSuccess;
  }

  Future<bool> TurnGeneratorEngineOnOff(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cloudUsername = prefs.getString(prefs_CloudUsername)!;
    String cloudPassword = prefs.getString(prefs_CloudPassword)!;
    GeneratorID = prefs.getString(prefs_GeneratorId)!;
    String Command;
    bool isSuccess = false;
    if (status)
      Command = "ON";
    else
      Command = "OFF";

    final responseAuth = await http.post(Uri.parse(cloudIotMautoAuthUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': cloudUsername,
          'password': cloudPassword,
        }));
    final token = jsonDecode((responseAuth.body))['token'];

    final response = await http.post(
      Uri.parse(cloudIotMautoSensorsUrl + GeneratorID),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token.toString()
      },
      body: jsonEncode([
        <String, String>{
          'generatorSensorID': dotenv.env['EngineOnOff_id'].toString(),
          'value': Command.toString(),
          //'timeStamp':DateTime.now().toString()
          'timeStamp': DateTime.now().toIso8601String(),
        }
      ]),
    );
    if (response.statusCode == 200) {
      isSuccess = true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to update sensor');
    }
    return isSuccess;
  }
}
