import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/photo_controller.dart';

class PhotoView extends GetView<PhotoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: controller.downloadImage,
        child: Icon(
          Icons.download,
        ),
        backgroundColor: mainColor,
      ),
      body: Obx(
        () => Column(
          children: [
            Container(
              height: 90.h,
              color: mainColor,
              child: PageHeaderWidget(
                title: 'view_photo'.tr,
                canBack: true,
                hasNotificationIcon: false,
                icon: const SizedBox(),
              ),
            ),
            Expanded(
                child: InteractiveViewer(
              child: controller.getPhotoUrl().isEmpty
                  ? Center(
                      child: SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Image.network(
                      controller.getPhotoUrl(),
                    ),
            )),
          ],
        ),
      ),
    );
  }
}
