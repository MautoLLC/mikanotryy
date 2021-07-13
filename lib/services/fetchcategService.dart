import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mymikano_app/models/categ.dart';
import 'package:mymikano_app/views/widgets/T5Expandable.dart';





class Service {

Future<List<Categ>> fetchCategs() async{

String url="https://picsum.photos/v2/list";
final response = await http.get(Uri.parse(url));
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