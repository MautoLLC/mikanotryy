import 'dart:convert';
import 'package:mymikano_app/models/RealEstateModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class RealEstatesService {
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

  Future<List<RealEstate>> fetchRealEstatesService() async {
    PrepareHeader();
    final response =
        await http.get(Uri.parse(GetRealEstatesURL), headers: headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      final listresult = json.map((e) => RealEstate.fromJson(e)).toList();

      return listresult;
    } else
      throw Exception('Error fetching');
  }
}
