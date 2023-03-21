import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:app/app/modules/pdfviewer/providers/pdfviewer_provider.dart';
import 'package:app/app/utils/utils.dart';
import 'package:get/get.dart';

class PdfviewerController extends GetxController {
  var isLoading = false.obs;

  var pdfUrl = ''.obs;

  var pdfDocument = PDFDocument().obs;

  void setIsLoading(bool value) => isLoading.value = value;
  bool getIsLoading() => isLoading.value;

  void setPdfUrlVar(String value) => pdfUrl.value = value;
  String getPdfUrlVar() => pdfUrl.value;

  void setPdfDocument(doc) => pdfDocument.value = doc;
  PDFDocument getPdfDocument() => pdfDocument.value;

  final PdfviewerProvider pdfviewerProvider;

  PdfviewerController({
    required this.pdfviewerProvider,
  });

  @override
  void onInit() {
    getPdfUrl();
    super.onInit();
  }

  void getPdfUrl() {
    setIsLoading(true);
    pdfviewerProvider.getPdfUrl().then((value) async {
      print(value.body);
      setIsLoading(false);
      if (value.statusCode == 200) {
        if (value.body['data'] != null) {
          setIsLoading(true);
          setPdfUrlVar(value.body['data']);
          await PDFDocument.fromURL(getPdfUrlVar()).then((pdf) {
            setPdfDocument(pdf);
            setIsLoading(false);
          });
        }
      }
    });
  }

  Future<void> downloadPdf() async {
    Functions.downloadFile(getPdfUrlVar(), true);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
