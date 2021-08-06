import 'dart:convert';
import 'package:mymikano_app/models/RealEstateModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:oauth2/oauth2.dart' as oauth2;


class RealEstatesService {

  Future<List<RealEstate>> fetchRealEstatesService() async{

    var client = await oauth2.clientCredentialsGrant(Uri.parse(authorizationEndpoint), identifier, secret);

    final response = await client.get(Uri.parse(GetRealEstatesURL));

    //print(response.body.toString());

    if (response.statusCode == 200)
    {
      final json= jsonDecode(response.body) as List<dynamic>;
      final listresult=json.map((e) => RealEstate.fromJson(e)).toList();

      return listresult;
    }
    else
      throw Exception('Error fetching');
  }

}