import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CvController extends GetxController {
  static CvController get I => Get.put(CvController());
  String pathPDF = "";
  String landscapePathPdf = "";
  String remotePDFpath = "";
  String corruptedPathPDF = "";
  final Completer<PDFViewController> ctl = Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  Future<File> createFileOfPdfUrl(resume) async {
    Completer<File> completer = Completer();
    try {
      final filename = resume.substring(resume.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(resume));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }

  Future<File> fromAsset(String asset, String filename) async {
    Completer<File> completer = Completer();
    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }
}
