import 'dart:convert';
import 'package:mymikano_app/models/ComponentStatusModel.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:oauth2/oauth2.dart' as oauth2;


class ComponentStatusService {

  Future<List<ComponentStatus>> fetchComponentStatus() async {
    var client = await oauth2.clientCredentialsGrant(
        Uri.parse(authorizationEndpoint), identifier, secret);
    final url = Uri.parse(ComponentsStatusURL);
print(url);
    final response = await client.get(url);
print(response.statusCode);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      final listresult = json.map((e) => ComponentStatus.fromJson(e)).toList();

      return listresult;
    }
    else
      throw Exception('Error fetching');
  }
}