import 'package:app/app/modules/home/controllers/account_controller.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class StockWatcherWidget extends GetView<AccountController> {
  const StockWatcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          width: 342.w,
          height: 100.h,
          margin: EdgeInsets.only(
              top: 320.h, left: 16.w, right: 15.w, bottom: 30.h),
          padding: EdgeInsets.only(top: 11.h, left: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              StockColumnWidget(
                icon: Ic.sharp_oil_barrel,
                close: controller.getOil()?.close ?? 0,
                change: controller.getOil()?.change ?? 0,
                change_p: controller.getOil()?.changeP ?? 0,
                title: 'oil_price'.tr,
              ),
              StockColumnWidget(
                icon: AntDesign.stock,
                isDowJones: true,
                close: controller.getDao()?.close ?? 0,
                change: controller.getDao()?.change ?? 0,
                change_p: controller.getDao()?.changeP ?? 0,
                title: 'dow_jones'.tr,
              ),
              StockColumnWidget(
                icon: Mdi.gold,
                close: controller.getGold()?.close ?? 0,
                change: controller.getGold()?.change ?? 0,
                change_p: controller.getGold()?.changeP ?? 0,
                title: 'gold'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
