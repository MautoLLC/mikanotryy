import 'dart:convert';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:oauth2/oauth2.dart' as oauth2;


class Service {

Future<List<Categ>> fetchCategs() async{

  var client = await oauth2.clientCredentialsGrant(Uri.parse(authorizationEndpoint), identifier, secret);
  final url = Uri.parse(GetMainCategoriesURL);

  final response = await client.get(url);

if (response.statusCode == 200)
{

  final json= jsonDecode(response.body) as List<dynamic>;
  final listresult=json.map((e) => Categ.fromJson(e)).toList();

  return listresult;
}
else
  throw Exception('Error fetching');
}

Future<List<Categ>> fetchSubCategs(int idMainCat) async{

  var client = await oauth2.clientCredentialsGrant(Uri.parse(authorizationEndpoint), identifier, secret);

  final url = Uri.parse(GetSubCategoriesURL+idMainCat.toString());

  final response = await client.get(url);

  if (response.statusCode == 200)
  {
    final json= jsonDecode(response.body) as List<dynamic>;
    final listresult=json.map((e) => Categ.fromJson(e)).toList();

    return listresult;

  }
  else
    {
    throw Exception('Error fetching');}
}


Future<List<Categ>> fetchAllCategs() async{

  var client = await oauth2.clientCredentialsGrant(Uri.parse(authorizationEndpoint), identifier, secret);
  final url =
  Uri.parse(GetAllCategoriesURL);


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