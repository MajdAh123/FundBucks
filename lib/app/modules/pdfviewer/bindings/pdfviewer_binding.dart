import 'package:app/app/modules/pdfviewer/providers/pdfviewer_provider.dart';
import 'package:get/get.dart';

import '../controllers/pdfviewer_controller.dart';

class PdfviewerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PdfviewerProvider>(PdfviewerProvider());
    Get.lazyPut<PdfviewerController>(
      () =>
          PdfviewerController(pdfviewerProvider: Get.find<PdfviewerProvider>()),
    );
  }
}
