import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:mymikano_app/models/GeneratorModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class ApiConfigurationService {
  void resetESP(String url) async {
    final response = await http.get(Uri.parse("http://" + url + "/reset"));
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

  // String RestartESP() {
  //   final response = http.get(Uri.parse(ssidRestartUrl));
  //   return "";
  // }

  Future<List<String>> getSSIDList() async {
    Dio dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return null;
    };
    try {
      final response = await dio.get(("http://192.168.4.1"));
      List<String> ssids = [];
      if (response.statusCode == 200) {
        print(response.data.toString());
        dom.Document document = parse(response.data);

        document
            .getElementsByTagName('li')
            .map((e) => e.innerHtml)
            .forEach((element) {
          print(element);
          String ssidName = element.toString();
          final splitted = ssidName.split(' (');
          ssids.add(splitted[0]);
        });
        return ssids;
      } else {
        print(response.data.toString());
        return ssids;
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Generator>> getGeneratorsOfUser(
      String cloudUsername, String cloudPassword) async {
    List<Generator> generators = [];
    Dio dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return null;
    };
    try {
      final responseAuth = await dio.post(cloudIotMautoAuthUrl,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
          data: {
            'email': cloudUsername,
            'password': cloudPassword,
          });

      final isAuthenticated = (responseAuth.data)['isAuthenticated'];
      if (isAuthenticated == false) {
        return [];
      }

      final token = (responseAuth.data)['token'];
      final userID = (responseAuth.data)['id'];

      final response = await dio.get(
        (cloudIotMautoUserGeneratorsUrl + userID),
        options:
            Options(headers: {'Authorization': 'Bearer ' + token.toString()}),
      );

      if (response.statusCode == 200) {
        generators = List<Generator>.from(
            response.data.map((x) => Generator.fromJson(x)));
        return generators;
      } else {
        print(response.data.toString());
        return generators;
      }
    } catch (e) {
      print(e);
      return generators;
    }
  }
}
