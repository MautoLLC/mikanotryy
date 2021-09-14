import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> ReturnToken() async {
  Directory directory = await getApplicationDocumentsDirectory();
  File file = File('${directory.path}/credentials.json');
  String fileContent = await file.readAsString();
  return fileContent;
}

SubmitMaintenanceRequest(
    MaintenanceRequestModel mMaintenanceRequest, BuildContext context) async {
  final url = Uri.parse(PostMaintenaceRequestURL);

  Future<String> token = ReturnToken();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var request = new http.MultipartRequest("POST", url);
  request.headers['Authorization'] = 'Bearer $token';
  //request.fields['idMaintenanceRequest'] = 1.toString();
  request.fields['maintenanceCategoryId'] =
      mMaintenanceRequest.maintenanceCategoryId.toString();
  request.fields['preferredVisitTime'] =
      mMaintenanceRequest.preferredVisitTime.toString();
  request.fields['realEstateId'] = mMaintenanceRequest.realEstateId.toString();
  request.fields['userId'] = prefs.getString('UserID').toString();
  request.fields['requestDescription'] =
      mMaintenanceRequest.requestDescription.toString();

  List<dynamic>? mImages = mMaintenanceRequest.maintenanceRequestImagesFiles;
  List<String>? mRecords = mMaintenanceRequest.maintenanceRequestRecordsFiles;
  List<MultipartFile> newList = [];

  for (int i = 0; i < mImages!.length; i++) {
    //File imageFile = File(assets[i].toString());
    File imageFile = await getImageFileFromAssets(mImages[i]);
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var imagemultipartFile = new http.MultipartFile("FormFiles", stream, length,
        filename: basename(imageFile.path));
    newList.add(imagemultipartFile);
  }
  for (int i = 0; i < mRecords!.length; i++) {
    File recordFile = File(mRecords[i]);
    var stream =
        new http.ByteStream(DelegatingStream.typed(recordFile.openRead()));
    var length = await recordFile.length();
    var voicemultipartFile = new http.MultipartFile("FormFiles", stream, length,
        filename: basename(recordFile.path));
    newList.add(voicemultipartFile);
  }

  request.files.addAll(newList);

  request.send().then((response) {
    if (response.statusCode == 201) {
      print("Uploaded!");
      Fluttertoast.showToast(
          msg: "Request submitted successfully ! ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: t13_edit_text_color,
          textColor: Colors.black87,
          fontSize: 16.0);
      Navigator.pop(context);
    } else {
      print("Failed to submit !" + response.toString());
      Fluttertoast.showToast(
          msg: "Error in submitting request ! ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: t13_edit_text_color,
          textColor: Colors.black87,
          fontSize: 16.0);
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
  String? name = asset.name;
  final file = File('$appDocPath/$name');
  // File file = File('$appDocPath/images/theme5/logo-dark.png'); //
  //   String fileContent = await file.readAsString();
  //  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}
