import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> SubmitMaintenanceRequest(
    MaintenanceRequestModel mMaintenanceRequest, BuildContext context) async {
  final url = Uri.parse(PostMaintenaceRequestURL);

  SharedPreferences prefs = await SharedPreferences.getInstance();

  var request = new http.MultipartRequest("POST", url);
  request.headers['Authorization'] = 'Bearer ${prefs.getString("accessToken")}';
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
  List<dynamic>? mRecords = mMaintenanceRequest.maintenanceRequestRecordsFiles;
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

  Fluttertoast.showToast(
      msg: "Request is being processed, please wait! ",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.white,
      textColor: Colors.black87,
      fontSize: 16.0);
  StreamedResponse response = await request.send();
  if (response.statusCode == 201) {
    print("Uploaded!");
    return true;
  } else {
    print(response.reasonPhrase);
  }
  return false;
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
