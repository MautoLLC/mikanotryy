import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:path_provider/path_provider.dart';

SubmitMaintenanceRequest(int categoryId,int realEstateId, DateTime visitTime, String Desc,List<Asset>? assets,List<String>? records) async {
  final authorizationEndpoint =
  Uri.parse('https://dev.codepickles.com:8443/auth/realms/master/protocol/openid-connect/token');

  final identifier = 'MymikanoApp';
  final secret = '9abafef9-82fe-4360-8283-ee7d2e8b3879';

  var client = await oauth2.clientCredentialsGrant(
      authorizationEndpoint, identifier, secret);

  final url =
  Uri.parse('http://dev.codepickles.com:8085/api/MaintenanceRequests');

   String token = client.credentials.toJson();

  var request = new http.MultipartRequest("POST", url);
  request.headers['Authorization'] = 'Bearer $token';
  //request.fields['idMaintenanceRequest'] = 1.toString();
  request.fields['maintenanceCategoryId'] = categoryId.toString();
  request.fields['preferredVisitTime'] = visitTime.toString();
  request.fields['realEstateId'] = realEstateId.toString();
  request.fields['userId'] = 1.toString();
  request.fields['requestDescription'] = Desc.toString();

   List<MultipartFile> newList = [];
  for (int i = 0; i < assets!.length; i++) {
    //File imageFile = File(assets[i].toString());
    File imageFile = await getImageFileFromAssets(assets[i]);
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var imagemultipartFile = new http.MultipartFile("FormFiles", stream, length, filename: basename(imageFile.path));
    newList.add(imagemultipartFile);
  }
  for (int i = 0; i < records!.length; i++) {
    File recordFile = File(records[i]);
    var stream = new http.ByteStream(DelegatingStream.typed(recordFile.openRead()));
    var length = await recordFile.length();
    var voicemultipartFile = new http.MultipartFile("FormFiles", stream, length, filename: basename(recordFile.path));
    newList.add(voicemultipartFile);
  }


  request.files.addAll(newList);


 // var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
//  var length = await imageFile.length();
//   var multipartFile = new http.MultipartFile(
//       'FormFiles', stream, length,
//       filename: basename(imageFile.path));

  //request.files.add(multipartFile);

  request.send().then((response) {
    if (response.statusCode == 201)
      {
      print("Uploaded!");
      Fluttertoast.showToast(
          msg: "Request submitted successfully ! " ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: t13_edit_text_color ,
          textColor: Colors.black87,
          fontSize: 16.0
      );
      }
    else{
      print("Failed to submit !");
      Fluttertoast.showToast(
          msg: "Error in submitting request ! " ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: t13_edit_text_color ,
          textColor: Colors.black87,
          fontSize: 16.0
      );

    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  });
}

Future<File> getImageFileFromAssets(Asset? asset) async {
  //   final byteData = await rootBundle.load('$path');
  final byteData = await asset!.getByteData();
  final directory = await getTemporaryDirectory();
  String appDocPath = directory.path;
  String? name=asset.name;
  final file = File('$appDocPath/$name');
  // File file = File('$appDocPath/images/theme5/logo-dark.png'); //
  //   String fileContent = await file.readAsString();
  //  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}