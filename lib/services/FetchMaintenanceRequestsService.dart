import 'dart:convert';
import 'dart:io';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MaintenanceRequestService {
  var headers;

  Future<void> PrepareHeader() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/credentials.json');
    String fileContent = await file.readAsString();
    headers = {
      "Accept": "application/json",
      'Authorization': 'Bearer $fileContent',
      "Connection": "keep-alive"
    };
  }

  Future<List<MaintenanceRequestModel>> fetchMaintenanceRequest() async {
    await PrepareHeader();
    late final response;
    try {
      response =
          await http.get(Uri.parse(GetMaintenaceRequestURL), headers: headers);
    } on Exception catch (e) {
      print(e.toString());
    }

    print(response.statusCode);
    for (var item in jsonDecode(response.body)) {
      print(item['maintenanceCategoryIcon']);
    }
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      final listresult =
          json.map((e) => MaintenanceRequestModel.fromJson(e)).toList();
      return listresult;
    } else {
      print(Uri.parse(GetMaintenaceRequestURL).toString());
      print(response.body.toString());
      throw Exception('Error fetching');
    }
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
