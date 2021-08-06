import 'dart:convert';
import 'package:mymikano_app/models/RealEstateModel.dart';
import 'package:oauth2/oauth2.dart' as oauth2;


class RealEstatesService {

  Future<List<RealEstate>> fetchRealEstatesService() async{

    final authorizationEndpoint =
    Uri.parse('https://dev.codepickles.com:8443/auth/realms/master/protocol/openid-connect/token');

    final identifier = 'MymikanoApp';
    final secret = '9abafef9-82fe-4360-8283-ee7d2e8b3879';

    var client = await oauth2.clientCredentialsGrant(
               authorizationEndpoint, identifier, secret);
    final url = Uri.parse('http://dev.codepickles.com:8085/api/RealEstates');
    print(url);
    final response =
    await client.get(url);

    print(response.body.toString());

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