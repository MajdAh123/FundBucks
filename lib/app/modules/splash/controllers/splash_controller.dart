import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import 'package:app/app/data/data.dart';
import 'package:app/app/modules/splash/providers/splash_provider.dart';
import 'package:app/app/utils/constant.dart';
import 'package:open_store/open_store.dart';

class SplashController extends GetxController {
  final SplashProvider splashProvider;
  SplashController({
    required this.splashProvider,
  });

  final presistentData = PresistentData();

  var isThereNewUpdate = false.obs;
  var creatAccountChoice = true.obs;

  var newAppVersion = ''.obs;
  var newAppDesc = ''.obs;
  var mustUpdate = false.obs;
  var appleAppId = ''.obs;

  var isLoading = false.obs;

  static final _auth = LocalAuthentication();
  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      return <BiometricType>[];
    }
  }

  // getauth() async {
  Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
          localizedReason: 'Scan your fingerprint',
          // useErrorDialogs: true,
          // stickyAuth: true,
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
            // biometricOnly: true,
          ));
    } on PlatformException catch (e) {
      print("{{{{{{{{{{{{{{}}}}}}}}}}}}}}");
      print(e.message);
      print(e.code);
      print("{{{{{{{{{{{{{{}}}}}}}}}}}}}}");
      return false;
    }
  }

  // await authenticate();
  // }

  @override
  Future<void> onInit() async {
    print('onInit');
    precacheImage(
        const AssetImage('assets/images/png/snackbarLogo.png'), Get.context!);
    final presistentData = PresistentData();

    String? langCode = await presistentData.readLocaleCode();
    if (langCode == null) {
      langCode = 'en';
    }
    // presistentData.getDarkMode() ?? false;

    Get.updateLocale(Locale(langCode));
    checkUpdate();
    // presistentData.changeFontFamily();

    super.onInit();
  }

  void checkUpdate() {
    isLoading.value = true;
    splashProvider.checkUpdate().then((value) {
      isLoading.value = false;
      if (value.statusCode == 200) {
        print(value.body);
        final isAndroid = (defaultTargetPlatform == TargetPlatform.android);

        if ((isAndroid
                ? value.body['data']['version']
                : value.body['data']['apple_version']) ==
            null) {
          return;
        }
        newAppVersion.value = (isAndroid
            ? value.body['data']['version']
            : value.body['data']['apple_version']) as String;
        newAppDesc.value = ((isAndroid
                ? value.body['data']['desc']
                : value.body['data']['apple_desc']) ??
            '') as String;
        mustUpdate.value = (isAndroid
            ? value.body['data']['must_update']
            : value.body['data']['apple_must_update']) as bool;
        appleAppId.value = (value.body['data']['apple_app_id'] ?? '') as String;

        creatAccountChoice.value =
            value.body['data']['accept_new_users'] as bool;

        isThereNewUpdate.value = checkIsThereNewUpdate(newAppVersion.value);
      }
    });
  }

  bool checkIsThereNewUpdate(version) {
    print(appVersion.compareTo("1.2.2+14"));
    return appVersion.compareTo(version) != 0;
  }

  void _showUpdateDiaolog() {
    Get.dialog(
      barrierDismissible: !mustUpdate.value,
      WillPopScope(
        onWillPop: () async {
          return !mustUpdate.value;
        },
        child: Column(
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
                          'new_update'.tr,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          newAppDesc.value,
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
                                // margin: EdgeInsets.only(
                                //     left: 10.w, right: 10.w, bottom: 10.h),
                                child: TextButton(
                                  onPressed: () {
                                    OpenStore.instance.open(
                                      appStoreId: appleAppId
                                          .value, // AppStore id of your app for iOS
                                      androidAppBundleId:
                                          'com.fundbucks.app', // Android app bundle package name
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    // minimumSize: const Size.fromHeight(50),
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
                                      'update_version'.tr,
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
                            !mustUpdate.value
                                ? Expanded(
                                    child: Container(
                                      // margin: EdgeInsets.only(
                                      //     left: 10.w,
                                      //     right: 10.w,
                                      //     bottom: 10.h),
                                      child: TextButton(
                                        onPressed: () {
                                          // Get.clo(1);
                                          if (Get.isDialogOpen ?? false) {
                                            Get.back(closeOverlays: true);
                                          }
                                        },
                                        style: TextButton.styleFrom(
                                          // minimumSize:
                                          //     const Size.fromHeight(50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          // primary: mainColor,
                                          backgroundColor: Colors.grey[300],
                                        ),
                                        child: Center(
                                          child: Text(
                                            'maybe_later'.tr,
                                            style: TextStyle(
                                              //fontFamily: FontFamily.inter,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: ThemeController
                                                      .to.getIsDarkMode
                                                  ? mainColorDarkTheme
                                                  : mainColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
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
      ),
    );
  }

  void navigateBasedOnLogin() async {
    final authToken = presistentData.getAuthToken();
    if (authToken != null) {
      if (authToken.isNotEmpty) {
        Get.offNamedUntil(
          '/home',
          ModalRoute.withName('toNewHome'),
        );
        // bool isAuth = await authenticate();
        // if (isAuth) {
        //   Get.offNamedUntil(
        //     '/home',
        //     ModalRoute.withName('toNewHome'),
        //   );
        // } else {
        //   while (!isAuth) {
        //     isAuth = await authenticate();
        //     if (isAuth) {
        //       Get.offNamedUntil(
        //         '/home',
        //         ModalRoute.withName('toNewHome'),
        //       );
        //     }
        //   }
        // }

        return;
      }
    }
    // Get.offAndToNamed('/login');
    print('create account value: ${creatAccountChoice.value}');
    Get.offNamedUntil(
      '/login',
      ModalRoute.withName('toNewestLogin'),
      arguments: [
        creatAccountChoice.value,
      ],
    );
    if (isThereNewUpdate.value) {
      _showUpdateDiaolog();
    }
    return;
  }

  @override
  void onReady() {
    print('onReady');
    super.onReady();
    ever(isLoading, (value) {
      print(value);
      if (!value) {
        new Future.delayed(
          Duration(seconds: splashScreenSeconds),
          () {
            navigateBasedOnLogin();
          },
        );
      }
    });
    // isLoading.value
    //     ? null
    //     : new Future.delayed(
    //         Duration(seconds: splashScreenSeconds),
    //         () {
    //           navigateBasedOnLogin();
    //         },
    //       );
  }

  @override
  void onClose() {}
}
