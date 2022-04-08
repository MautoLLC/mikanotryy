import 'dart:convert';

import 'package:html/parser.dart';
import 'package:mymikano_app/models/GeneratorModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;



class ApiConfigurationService {
  void resetESP() async {
    final response = await http.get(Uri.parse(resetESPUrl));
    if (response.statusCode == 200) {
      print(response.body.toString());
    } else {
      throw Exception('Failed to reset ESP');
    }
  }

  Future<String> Connecttossid(String id, String pass, String cloudUsername,
      String cloudPassword, String cloudMode, String generatorId) async {
    final response = await http.get(Uri.parse(ssidUrl +
        '/setting?ssid=' +
        id +
        '&pass=' +
        pass +
        '&clouduserN=' +
        cloudUsername +
        '&cloudpassw=' +
        cloudPassword +
        '&cmode=' +
        cloudMode +
        '&GeneratorId=' +
        generatorId));
    if (response.statusCode == 200) {
      print(response.body.toString());
      return (response.body.toString());
    } else {
      return (response.body.toString());
    }
  }

  String RestartESP() {
    final response = http.get(Uri.parse(ssidRestartUrl));
    return "";
  }

  Future<List<String>> getSSIDList() async {
    final response = await http.get(Uri.parse("http://192.168.4.1"));
    List<String> ssids = [];
    if (response.statusCode == 200) {
      print(response.body.toString());
      dom.Document document = parse(response.body);

      document
          .getElementsByTagName('li')
          .map((e) => e.innerHtml)
          .forEach((element) {
        print(element);
        ssids.add(element);
      });
      return ssids;
    } else {
      print(response.body.toString());
      return ssids;
    }
  }

  Future<List<String>> getGeneratorsOfUser(
      String cloudUsername, String cloudPassword) async {
    List<String> generatorIDs = [];
    final responseAuth = await http.post(Uri.parse(cloudIotMautoAuthUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': cloudUsername,
          'password': cloudPassword,
        }));

    final token = jsonDecode((responseAuth.body))['token'];
    final userID = jsonDecode((responseAuth.body))['id'];

    final response = await http.get(
        Uri.parse(cloudIotMautoUserGeneratorsUrl + userID),
        headers: {'Authorization': 'Bearer ' + token.toString()});

    if (response.statusCode == 200) {
      List<Generator> generators = List<Generator>.from(
          json.decode(response.body).map((x) => Generator.fromJson(x)));

      for (Generator generator in generators) {
        generatorIDs.add(generator.generatorId);
      }
      return generatorIDs;
    } else {
      print(response.body.toString());
      return generatorIDs;
    }
  }
}
