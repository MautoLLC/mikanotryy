import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewScreen extends StatelessWidget {
  String Path = '';
  String Code = '';

  PDFViewScreen({Key? key, required this.Path, required this.Code})
      : super(key: key);

  void DownloadPDF() async {
    try {
      Dio dio = Dio();
      Response response =
          await dio.download(Path, "/storage/emulated/0/Download/${Code}.pdf");
      if (response.statusCode == 200) {
        toast("Downloaded Successfully");
      } else {
        toast("Failed to Download");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      child: Center(
        child: Stack(children: [
          SfPdfViewer.network(
            Path,
            canShowScrollStatus: true,
            enableTextSelection: true,
            canShowPaginationDialog: true,
            canShowScrollHead: true,
            pageLayoutMode: PdfPageLayoutMode.continuous,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: mainColorTheme),
                  child: IconButton(
                    icon: Icon(Icons.download),
                    color: Colors.white,
                    onPressed: () {
                      DownloadPDF();
                    },
                  )),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                )),
          ),
        ]),
      ),
    )));
  }
}
