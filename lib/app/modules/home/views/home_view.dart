import 'package:app/app/modules/home/views/account_page_view.dart';
import 'package:app/app/modules/home/views/contact_page_view.dart';
import 'package:app/app/modules/home/views/operation_page_view.dart';
import 'package:app/app/modules/home/views/profile_page_view.dart';
import 'package:app/app/modules/home/views/report_page_view.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: StretchedBottomNavigationBar(),
        backgroundColor: ThemeController.to.getIsDarkMode
            ? backgroundColorDarkTheme
            : backgroundColorLightTheme,
        body: controller.getIsLoading()
            ? Center(
                child: SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(),
                ),
              )
            : controller.getIsError()
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'something_happened'.tr,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ElevatedButton.icon(
                            onPressed: controller.getUserApi,
                            icon: Icon(Icons.refresh_outlined),
                            label: Text('reload'.tr)),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 0.h),
                    child: IndexedStack(
                      index: controller.index.value,
                      children: [
                        AccountPageView(),
                        ReportPageView(),
                        OperationPageView(),
                        ContactPageView(),
                        ProfilePageView(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
