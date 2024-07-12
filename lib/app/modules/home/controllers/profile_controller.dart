import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:app/app/data/data.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/home/providers/auth_provider.dart';

import '../../../widgets/snack_Bar_Awesome_widget.dart';

class ProfileController extends GetxController {
  final AuthProvider authProvider;

  ProfileController({
    required this.authProvider,
  });

  final presistentData = PresistentData();

  var isLoading = false.obs;

  final globalFormKey = GlobalKey<FormState>().obs;

  void setIsLoading(value) => isLoading.value = value;
  bool getIsLoading() => isLoading.value;

  final homeController = Get.find<HomeController>();

  String getFullName() {
    return Functions.fullname(homeController.getUser()?.firstname,
        homeController.getUser()?.lastname);
  }

  String getUserCurrency() {
    return Functions.getCurrency(homeController.getUser());
  }

  bool getIsTestAccount() =>
      homeController.getUser()?.type?.compareTo('test') == 0;

  bool getIfUserCanHaveTestMode() =>
      num.parse(homeController.getUser()?.balance ?? '0') == 0 ||
      homeController.getUser()?.type?.compareTo('test') == 0;

  @override
  void onInit() {
    super.onInit();
  }

  void signOut() async {
    setIsLoading(true);
    final FormData _formData = FormData({
      'fcm': null,
    });
    await authProvider.setNotification(_formData).then((value) {
      setIsLoading(false);
      if (value.statusCode == 200) {
        print('success');
        presistentData.writeAuthToken('');
        Get.offNamedUntil('/login', ModalRoute.withName('toNewLogin'));
      }
    });
  }

  void changeAccountMode() {
    setIsLoading(true);
    homeController.setIsLoading(true);
    authProvider.changeAccountMode().then((value) {
      setIsLoading(false);
      if (value.statusCode == 200) {
        homeController.getUserApi();
        final getIsTestMode =
            homeController.getUser()?.type?.compareTo('test') == 0;

        SnackBarWidgetAwesome(
          'success'.tr,
          getIsTestMode ? 'enable_test_mode'.tr : 'disable_test_mode'.tr,
        );
        // Get.showSnackbar(GetSnackBar(
        //   title: 'success'.tr,
        //   message:
        //       getIsTestMode ? 'enable_test_mode'.tr : 'disable_test_mode'.tr,
        //   duration: const Duration(seconds: defaultSnackbarDuration),
        // ));
        print('changed mode');
      }
    });
  }

  void showTestModeDialog() {
    Get.dialog(
      barrierDismissible: true,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 10.h),
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: ThemeController.to.getIsDarkMode
                      ? containerColorDarkTheme
                      : containerColorLightTheme,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: ThemeController.to.getIsDarkMode
                        ? greyColor.withOpacity(.39)
                        : greyColor,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        'alert'.tr,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        getIsTestAccount()
                            ? 'alert_will_disable_test_mode'.tr
                            : 'alert_will_enable_test_mode'
                                .trParams({'currency': getUserCurrency()}),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30.h),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: TextButton(
                                onPressed: () {
                                  if (Get.isDialogOpen ?? false) {
                                    // Get.back(closeOverlays: true);
                                    Get.close(1);
                                  }
                                  changeAccountMode();
                                },
                                style: TextButton.styleFrom(
                                  // minimumSize: const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  // primary: mainColor,
                                  backgroundColor:
                                      ThemeController.to.getIsDarkMode
                                          ? secondaryColorDarkTheme
                                          : secondaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    'agree'.tr,
                                    style: TextStyle(
                                      //fontFamily: FontFamily.inter,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Container(
                              child: TextButton(
                                onPressed: () {
                                  if (Get.isDialogOpen ?? false) {
                                    // Get.back(closeOverlays: true);
                                    Get.close(1);
                                  }
                                },
                                style: TextButton.styleFrom(
                                  // minimumSize:
                                  //     const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  // primary: mainColor,
                                  backgroundColor:
                                      ThemeController.to.getIsDarkMode
                                          ? mainColorDarkTheme
                                          : mainColor,
                                ),
                                child: Center(
                                  child: Text(
                                    'close'.tr,
                                    style: TextStyle(
                                      //fontFamily: FontFamily.inter,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changeTheme(bool? themeMode) {
    if (themeMode == null) {
      return;
    }

    final themeController = Get.find<ThemeController>();
    themeController.toggleTheme();

    Get.forceAppUpdate();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
