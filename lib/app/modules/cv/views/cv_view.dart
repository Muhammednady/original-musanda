import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

import '../../../../config/myColor.dart';
import '../controllers/cv_controller.dart';

class CvView extends GetView<CvController> {
  const CvView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary,
        title: const Text('CvView'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: Get.arguments,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: controller.currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation: false,
            onRender: (pages) {
              controller.pages = pages;
              controller.isReady = true;
            },
            onError: (error) {
              controller.errorMessage = error.toString();
            },
            onPageError: (page, error) {
              controller.errorMessage = '$page: ${error.toString()}';
            },
            onViewCreated: (PDFViewController pdfViewController) {
              controller.ctl.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {},
            onPageChanged: (int? page, int? total) {
              controller.currentPage = page;
            },
          ),
          controller.errorMessage.isEmpty
              ? controller.isReady
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(controller.errorMessage),
                )
        ],
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: controller.ctl.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              label: Text("Go to ${controller.pages! ~/ 2}"),
              onPressed: () async {
                await snapshot.data!.setPage(controller.pages! ~/ 2);
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
