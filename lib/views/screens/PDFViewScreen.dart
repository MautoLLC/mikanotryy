import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../State/PDFState.dart';

class PDFViewScreen extends StatelessWidget {
  String Path = '';
  String Code = '';

  PDFViewScreen({Key? key, required this.Path, required this.Code})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PDFState>(
      builder: (context, pdfState, child) => SafeArea(
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
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: pdfState.downloadProgressBarVisible,
                      child: Expanded(
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: mainColorTheme),
                        child: IconButton(
                          icon: Icon(Icons.download),
                          color: Colors.white,
                          onPressed: () {
                            pdfState.DownloadPDF(Path, Code);
                          },
                        )),
                  ],
                ),
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
      ))),
    );
  }
}
