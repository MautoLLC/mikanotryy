import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PDFState extends ChangeNotifier {
  bool downloadProgressBarVisible = false;
  int progress = 0;

  void toggleProgressBarVisibility(bool state) {
    downloadProgressBarVisible = state;
    notifyListeners();
  }

  void DownloadPDF(String Path, String Code) async {
    try {
      PermissionStatus status = await Permission.storage.request();
      toast("Pdf is downloading, please wait.");
      Directory? directory;
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getExternalStorageDirectory();
      }
      // List<Directory>? directories = await getExternalStorageDirectories();

      try {
        toggleProgressBarVisibility(true);
        notifyListeners();
        Dio dio = Dio();
        Response response = await dio.download(
          Path,
          "${directory!.path.toString()}/${Code}.pdf",
          onReceiveProgress: (count, total) => progress = total,
        );
        if (response.statusCode == 200) {
          toast("Downloaded Successfully");
        } else {
          toast("Failed to Download");
        }
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        toggleProgressBarVisibility(false);
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }
}
