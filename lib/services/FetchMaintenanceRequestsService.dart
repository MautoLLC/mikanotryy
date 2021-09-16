import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AuthorizationInterceptor.dart';

class MaintenanceRequestService {
  var headers;

  Future<void> PrepareHeader() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/credentials.json');
    String fileContent = await file.readAsString();
    headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $fileContent',
      "Connection": "keep-alive"
    };
  }

  Future<List<MaintenanceRequestModel>> fetchAllMaintenanceRequest() async {
    await PrepareHeader();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print(headers);
    final response;
    late final listresult;
    try {
      response = await http.get(Uri.parse(GetMaintenaceRequestURL));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as List<dynamic>;
        listresult =
            json.map((e) => MaintenanceRequestModel.fromJson(e)).toList();
      } else {
        print(Uri.parse(GetMaintenaceRequestURL).toString());
        print(response.body.toString());
        throw Exception('Error fetching');
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return listresult;
  }

  Future<List<MaintenanceRequestModel>> fetchMaintenanceRequest() async {
    await PrepareHeader();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print(headers);
    final response;
    late final listresult;
    Client client = InterceptedClient.build(interceptors: [
      AuthorizationInterceptor(),
    ]);
    try {
      response = await client.get(Uri.parse(GetMaintenaceRequestURL +
          '/UserRequests/' +
          prefs.getString('UserID').toString()));
      print(response.statusCode);
      print(response.body);
      for (var item in jsonDecode(response.body)) {
        print(item);
      }
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as List<dynamic>;
        listresult =
            json.map((e) => MaintenanceRequestModel.fromJson(e)).toList();
      } else {
        print(Uri.parse(GetMaintenaceRequestURL).toString());
        print(response.body.toString());
        throw Exception('Error fetching');
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return listresult;
  }

  Future<MaintenanceRequestModel> fetchMaintenanceRequestByID(int id) async {
    PrepareHeader();
    final response = await http.get(Uri.parse(GetMaintenaceRequestURL + '/$id'),
        headers: headers);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return MaintenanceRequestModel.fromJson(json);
    } else {
      print(response.body.toString());
      throw Exception('Error fetching');
    }
  }
}
