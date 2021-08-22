import 'dart:convert';
import 'dart:io';
import 'package:mymikano_app/models/ComponentStatusModel.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ComponentStatusService {
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

  Future<List<ComponentStatus>> fetchComponentStatus() async {
    final url = Uri.parse(ComponentsStatusURL);
    PrepareHeader();
    final response = await http.get(url, headers: headers);
    print(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      final listresult = json.map((e) => ComponentStatus.fromJson(e)).toList();

      return listresult;
    } else
      throw Exception('Error fetching');
  }
}
