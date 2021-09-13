import 'dart:convert';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Service {
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

  Future<List<Categ>> fetchCategs() async {
    final url = Uri.parse(GetMainCategoriesURL);

    PrepareHeader();
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      final listresult = json.map((e) => Categ.fromJson(e)).toList();

      return listresult;
    } else
      throw Exception('Error fetching');
  }

  Future<List<Categ>> fetchSubCategs(int idMainCat) async {
    final url = Uri.parse(GetSubCategoriesURL + idMainCat.toString());

    PrepareHeader();
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      final listresult = json.map((e) => Categ.fromJson(e)).toList();

      return listresult;
    } else {
      throw Exception('Error fetching');
    }
  }

  Future<List<Categ>> fetchAllSubCategs() async {
    final url = Uri.parse(GetSubCategoriesURL);

    PrepareHeader();
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      final listresult = json.map((e) => Categ.fromJson(e)).toList();

      return listresult;
    } else {
      throw Exception('Error fetching');
    }
  }

  Future<List<Categ>> fetchAllCategs() async {
    final url = Uri.parse(GetAllCategoriesURL);

    PrepareHeader();
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      print(json[3]["maintenanceCategoryIcon"]);
      final listresult = json.map((e) => Categ.fromJson(e)).toList();

      return listresult;
    } else
      throw Exception('Error fetching');
  }
}
