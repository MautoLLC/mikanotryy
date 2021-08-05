import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/views/widgets/T5Expandable.dart';
import 'package:oauth2/oauth2.dart' as oauth2;



class Service {

Future<List<Categ>> fetchCategs() async{

  final authorizationEndpoint =
  Uri.parse(
      'https://dev.codepickles.com:8443/auth/realms/master/protocol/openid-connect/token');


  final identifier = 'MymikanoApp';
  final secret = '9abafef9-82fe-4360-8283-ee7d2e8b3879';

  var client = await oauth2.clientCredentialsGrant(
      authorizationEndpoint, identifier, secret);
  final url =
  Uri.parse(
      'http://dev.codepickles.com:8085/api/RealEstateMaintenanceCategories/MainRealEstateMaintenanceCategories');
  print(url);
  final response =
  await client.get(url);

  print(response.body.toString());
 // List jsonResponse = json.decode(response.body);
if (response.statusCode == 200)
{
  print("sally");
 // print(categs![1].mcateg!.maintenanceCategoryName);
  final json= jsonDecode(response.body) as List<dynamic>;
  final listresult=json.map((e) => Categ.fromJson(e)).toList();

  return listresult;
}
else
  throw Exception('Error fetching');
}

Future<List<Categ>> fetchSubCategs(int idMainCat) async{

  final authorizationEndpoint =
  Uri.parse(
      'https://dev.codepickles.com:8443/auth/realms/master/protocol/openid-connect/token');


  final identifier = 'MymikanoApp';
  final secret = '9abafef9-82fe-4360-8283-ee7d2e8b3879';

  var client = await oauth2.clientCredentialsGrant(
      authorizationEndpoint, identifier, secret);
  final url =
  Uri.parse(
      "http://dev.codepickles.com:8085/api/RealEstateMaintenanceCategories/ChildrenRealEstateMaintenanceCategories/"+idMainCat.toString() );
  print(url);

  final response = await client.get(url);

  // List jsonResponse = json.decode(response.body);
  if (response.statusCode == 200)
  {
    final json= jsonDecode(response.body) as List<dynamic>;
    final listresult=json.map((e) => Categ.fromJson(e)).toList();
    // print(json);
    // print(listresult);
    return listresult;

  }
  else
    {
    throw Exception('Error fetching');}
}



Future<List<Categ>> fetchAllCategs() async{

  final authorizationEndpoint =
  Uri.parse(
      'https://dev.codepickles.com:8443/auth/realms/master/protocol/openid-connect/token');


  final identifier = 'MymikanoApp';
  final secret = '9abafef9-82fe-4360-8283-ee7d2e8b3879';

  var client = await oauth2.clientCredentialsGrant(
      authorizationEndpoint, identifier, secret);
  final url =
  Uri.parse(
      "http://dev.codepickles.com:8085/api/RealEstateMaintenanceCategories");


  final response =
  await client.get(url);

  // List jsonResponse = json.decode(response.body);
  if (response.statusCode == 200)
  {
    final json= jsonDecode(response.body) as List<dynamic>;
    final listresult=json.map((e) => Categ.fromJson(e)).toList();

    return listresult;

  }
  else
    throw Exception('Error fetching');
}






}