import 'dart:convert';
import 'package:mymikano_app/models/InspectionModel.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';

class InspectionService {

  Future<List<InspectionModel>> fetchInspections() async{

    var client = await oauth2.clientCredentialsGrant(Uri.parse(authorizationEndpoint), identifier, secret);

    final response = await client.get(Uri.parse(GetInspectionURL));

    if (response.statusCode == 200)
    {
      final json= jsonDecode(response.body) as List<dynamic>;
      final listresult=json.map((e) => InspectionModel.fromJson(e)).toList();
      //print(Uri.parse(GetMaintenaceRequestURL).toString());
//print(response.body.toString());
      return listresult;
    }
    else
    {
      print(Uri.parse(GetInspectionURL).toString());
      print(response.body.toString());
      throw Exception('Error fetching');

    }
  }
  Future<List<InspectionModel>> fetchTechnicianInspections(int idTechnician) async{

    var client = await oauth2.clientCredentialsGrant(Uri.parse(authorizationEndpoint), identifier, secret);

    final response = await client.get(Uri.parse(GetTechnicianInspectionURL+idTechnician.toString()));

    if (response.statusCode == 200)
    {
      final json= jsonDecode(response.body) as List<dynamic>;
      final listresult=json.map((e) => InspectionModel.fromJson(e)).toList();

      return listresult;
    }
    else
    {
      print(Uri.parse(GetInspectionURL).toString());
      print(response.body.toString());
      throw Exception('Error fetching');

    }
  }
  Future<List<InspectionModel>> fetchInspectionbyId(int id) async{

    var client = await oauth2.clientCredentialsGrant(Uri.parse(authorizationEndpoint), identifier, secret);

    final response = await client.get(Uri.parse(GetInspectionURL+id.toString()));
    List<InspectionModel> listresult=[];
    if (response.statusCode == 200)
    {
      Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(response.body));
      InspectionModel inspection =  InspectionModel.fromJson(data);

      listresult.add(inspection);
      return listresult;


    }
    else
    {
      print(Uri.parse(GetInspectionURL).toString());
      print(response.body.toString());
      throw Exception('Error fetching');

    }
  }


}