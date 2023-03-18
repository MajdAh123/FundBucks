import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/pdfviewer_controller.dart';

class PdfviewerView extends GetView<PdfviewerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: controller.downloadPdf,
        child: Icon(
          Icons.download,
        ),
        backgroundColor: mainColor,
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: Column(
            children: [
              Container(
                height: 70.h,
                color: mainColor,
                child: PageHeaderWidget(
                  title: 'download_bank_details'.tr,
                  canBack: true,
                  hasNotificationIcon: false,
                  icon: const SizedBox(),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      left: 17.w, right: 16.w, top: 20.h, bottom: 15.h),
                  child: controller.getIsLoading() ||
                          controller.getPdfUrlVar().isEmpty
                      ? Center(
                          child: SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : PDFViewer(document: controller.getPdfDocument()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
