import 'package:app/app/modules/home/controllers/profile_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfilePageView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: 90.h,
            color: mainColor,
          ),
          PageHeaderWidget(title: 'profile'.tr),
          Container(
            margin: EdgeInsets.only(top: 70.h),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const ProfileAccountInformationWidget(),
                // PortfolioInformationWidget(),
                OptionItemWidget(
                    title: 'account_information'.tr,
                    onTap: () {
                      Get.toNamed('/edit-profile');
                    }),
                // Divider(height: 0, color: Colors.grey[400]),
                OptionItemWidget(
                  title: 'notifications'.tr,
                  onTap: () {
                    Get.toNamed('/notification');
                  },
                ),
                OptionItemWidget(
                    title: 'settings'.tr,
                    onTap: () {
                      Get.toNamed('/setting');
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (_) => const SettingScreen()));
                    }),
                // Divider(height: 0, color: Colors.grey[400]),
                OptionItemWidget(
                    title: 'faq'.tr, onTap: () => Get.toNamed('/support-card')),
                // Divider(height: 0, color: Colors.grey[400]),
                OptionItemWidget(
                    title: 'about'.tr,
                    onTap: () => Get.toNamed(
                          '/webview',
                          arguments: ['about'.tr, 2],
                        )),
                // Divider(height: 0, color: Colors.grey[400]),
                OptionItemWidget(
                    title: 'terms_and_conditions'.tr,
                    onTap: () => Get.toNamed(
                          '/webview',
                          arguments: ['terms_and_conditions'.tr, 1],
                        )),
                // Divider(height: 0, color: Colors.grey[400]),
                OptionItemWidget(
                  title: 'privacy_policy'.tr,
                  onTap: () => Get.toNamed(
                    '/webview',
                    arguments: ['privacy_policy'.tr, 0],
                  ),
                  isLastItem: true,
                ),
                // Divider(height: 0, color: Colors.grey[400]),
                LogoutItemWidget(),
                SizedBox(height: 25.h),
                // DeleteAccountItemWidget(),
                // SizedBox(height: 30.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LogoutItemWidget extends GetView<ProfileController> {
  const LogoutItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.fromLTRB(17.w, 18.h, 16.w, 0),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: controller.signOut,
          child: controller.getIsLoading()
              ? Center(
                  child: SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: CircularProgressIndicator(),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.power_settings_new, size: 20, color: mainColor),
                    SizedBox(width: 8.w),
                    Text('sign_out'.tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: mainColor,
                          //fontFamily: FontFamily.inter,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
        ),
      ),
    );
  }
}

// class DeleteAccountItemWidget extends GetView<ProfileController> {
//   const DeleteAccountItemWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Container(
//         margin: EdgeInsets.fromLTRB(17.w, 18.h, 16.w, 0),
//         child: GestureDetector(
//           behavior: HitTestBehavior.translucent,
//           onTap: controller.showDeleteAccountReasonDialog,
//           child: controller.getIsDeleteLoading()
//               ? Center(
//                   child: SizedBox(
//                     width: 20.w,
//                     height: 20.h,
//                     child: CircularProgressIndicator(),
//                   ),
//                 )
//               : Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Iconify(
//                       Ic.round_delete_outline,
//                       size: 20,
//                       color: Colors.red.shade400,
//                     ),
//                     SizedBox(width: 8.w),
//                     Text(
//                       'delete_account'.tr,
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: Colors.red.shade400,
//                         //fontFamily: FontFamily.inter,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }
