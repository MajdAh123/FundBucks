import 'package:app/app/modules/home/views/account_page_view.dart';
import 'package:app/app/modules/home/views/contact_page_view.dart';
import 'package:app/app/modules/home/views/operation_page_view.dart';
import 'package:app/app/modules/home/views/profile_page_view.dart';
import 'package:app/app/modules/home/views/report_page_view.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/logoAnimation.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // controller.navigatePage(controller.getIndex());
      return Scaffold(
          bottomNavigationBar: StretchedBottomNavigationBar(),
          backgroundColor: ThemeController.to.getIsDarkMode
              ? backgroundColorDarkTheme
              : backgroundColorLightTheme,
          body: controller.getIsLoading()
              ? Center(child: LoadingLogoWidget())
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
                      child: PageView.builder(
                        controller: controller.pageController,
                        itemCount: controller.allScreens.length,
                        itemBuilder: (context, index) {
                          return AnimatedBuilder(
                            animation: controller.pageController,
                            builder: (context, child) {
                              double value = 1.0;

                              if (controller
                                  .pageController.position.haveDimensions) {
                                value = controller.pageController.page! - index;
                                value =
                                    (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                              }

                              // Use the opacity animation controller's value
                              return Transform(
                                transform: Matrix4.identity()
                                  ..rotateY((1 - value) * 0.2)
                                  ..scale(value, value),
                                alignment: Alignment.center,
                                child: Obx(() => controller
                                    .allScreens[controller.getIndex()]),
                              );
                            },
                          );
                        },
                        onPageChanged: (index) {
                          controller.index.value = index;
                        },
                      ),
                    ));
    });
  }
}
