import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mymikano_app/models/CloudSensor_Model.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:nb_utils/nb_utils.dart';

class CloudDashBorad_Service {
  //final String ApiEndPoint;
  final String GeneratorID = "0d412e77-72c9-4b0e-5692-08d9fac193ec";
  late List<CloudSensor> cloudsensors = [];
  // CloudDashBorad_Service({required this.ApiEndPoint});

  Future<List<CloudSensor>> FetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cloudUsername = prefs.getString("CloudUsername")!;
    String cloudPassword = prefs.getString("CloudPassword")!;

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

  Future<String> SwitchControllerMode(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cloudUsername = prefs.getString("CloudUsername")!;
    String cloudPassword = prefs.getString("CloudPassword")!;
    String Mode;
    
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
      body: jsonEncode([<String, String>{
        'generatorSensorID':
            dotenv.env['ControllerMode_id'].toString(),
        'value': Mode.toString(),
        //'timeStamp':DateTime.now().toString()
        'timeStamp': DateTime.now().toIso8601String()
      }]),
    );
    
    if (response.statusCode == 200) {
      return response.toString();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to update sensor');
    }
  }

  Future<String> SwitchMCBMode(bool status) async {
    int Mode;
    if (status)
      Mode = 1;
    else
      Mode = 0;
    final response = await http.post(
      Uri.parse(cloudIotMautoSensorsUrl + GeneratorID),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'generatorSensorID': dotenv.env['MCBMode_id'].toString().toUpperCase(),
        'value': Mode.toString(),
        //'timeStamp':DateTime.now().toString()
        'timeStamp':  DateTime.now().toIso8601String()
      }),
    );

    if (response.statusCode == 201) {
      return response.toString();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to update sensor');
    }
  }

  Future<String> TurnGeneratorOnOff(bool status) async {
    int Command;
    if (status)
      Command = 0;
    else
      Command = 1;
    final response = await http.post(
      Uri.parse(cloudIotMautoSensorsUrl + GeneratorID),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'generatorSensorID':
            dotenv.env['EngineState_id'].toString().toUpperCase(),
        'value': Command.toString(),
        //'timeStamp':DateTime.now().toString()
        'timeStamp': '2022-03-10T19:51:32.073Z',
      }),
    );
    String now = DateTime.now().toString();
    if (response.statusCode == 201) {
      return response.toString();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to update sensor');
    }
  }
}
