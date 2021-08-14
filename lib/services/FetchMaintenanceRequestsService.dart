import 'dart:convert';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';

class MaintenanceRequestService {

  Future<List<MaintenanceRequestModel>> fetchMaintenanceRequest() async{

    var client = await oauth2.clientCredentialsGrant(Uri.parse(authorizationEndpoint), identifier, secret);

    final response = await client.get(Uri.parse(GetMaintenaceRequestURL));

    if (response.statusCode == 200)
    {
      final json= jsonDecode(response.body) as List<dynamic>;
      final listresult=json.map((e) => MaintenanceRequestModel.fromJson(e)).toList();
      //print(Uri.parse(GetMaintenaceRequestURL).toString());
//print(response.body.toString());
      return listresult;
    }
    else
    {
      print(Uri.parse(GetMaintenaceRequestURL).toString());
      print(response.body.toString());
      throw Exception('Error fetching');

    }
  }

}