import 'dart:convert';
import 'dart:io';
import 'package:mymikano_app/models/InspectionModel.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:http/http.dart' as http;
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:path_provider/path_provider.dart';

class InspectionService {
  var headers;

  void PrepareHeader() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/credentials.json');
    String fileContent = await file.readAsString();
    headers = {
      "Accept": "application/json",
      'Authorization': 'Bearer $fileContent'
    };
  }

  Future<List<InspectionModel>> fetchInspections() async {
    PrepareHeader();
    final response =
        await http.get(Uri.parse(GetInspectionURL), headers: headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      final listresult = json.map((e) => InspectionModel.fromJson(e)).toList();
      return listresult;
    } else {
      print(Uri.parse(GetInspectionURL).toString());
      print(response.body.toString());
      throw Exception('Error fetching');
    }
  }

  Future<List<InspectionModel>> fetchTechnicianInspections(
      int idTechnician) async {
    PrepareHeader();
    final response = await http.get(
        Uri.parse(GetTechnicianInspectionURL + idTechnician.toString()),
        headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      final listresult = json.map((e) => InspectionModel.fromJson(e)).toList();

      return listresult;
    } else {
      print(Uri.parse(GetInspectionURL).toString());
      print(response.body.toString());
      throw Exception('Error fetching');
    }
  }

  Future<List<InspectionModel>> fetchInspectionbyId(int id) async {
    PrepareHeader();
    final response = await http.get(Uri.parse(GetInspectionURL + id.toString()),
        headers: headers);
    List<InspectionModel> listresult = [];
    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          new Map<String, dynamic>.from(json.decode(response.body));
      InspectionModel inspection = InspectionModel.fromJson(data);

      listresult.add(inspection);
      return listresult;
    } else {
      print(Uri.parse(GetInspectionURL).toString());
      print(response.body.toString());
      throw Exception('Error fetching');
    }
  }
}
