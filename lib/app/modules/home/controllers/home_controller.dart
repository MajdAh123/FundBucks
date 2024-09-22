import 'dart:convert';
import 'dart:developer';
import 'package:app/app/modules/edit_profile/bindings/edit_profile_binding.dart';
import 'package:app/generated/inAppReview.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:app/app/data/data.dart';
import 'package:app/app/data/models/models.dart';
import 'package:app/app/modules/edit_profile/providers/user_provider.dart';
import 'package:app/app/modules/gateway_detail/views/gateway_detail_view.dart';
import 'package:app/app/modules/home/controllers/account_controller.dart';
import 'package:app/app/modules/home/controllers/contact_controller.dart';
import 'package:app/app/modules/home/controllers/operation_controller.dart';
import 'package:app/app/modules/home/controllers/report_controller.dart';
import 'package:app/app/modules/home/providers/auth_provider.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/utils/laravel_echo/laravel_echo.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:local_auth/local_auth.dart';
import 'package:open_store/open_store.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:in_app_review/in_app_review.dart';
import '../../../widgets/snack_Bar_Awesome_widget.dart';
import '../../edit_profile/controllers/edit_profile_controller.dart';
import '../views/account_page_view.dart';
import '../views/contact_page_view.dart';
import '../../../widgets/logoAnimation.dart';
import '../views/operation_page_view.dart';
import '../views/profile_page_view.dart';
import '../views/report_page_view.dart';

import 'profile_controller.dart';

class HomeController extends GetxController
    with WidgetsBindingObserver, GetSingleTickerProviderStateMixin {
  var index = 0.obs;
  // var previousIndex = 0.obs;
  final presistentData = PresistentData();
  PageController pageController = PageController();
  var isThereNotification = false.obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var isAlertLoading = false.obs;

  var alerts = <Alert>[].obs;

  Rx<User?> user = User().obs;

  final AuthProvider authProvider;

  HomeController({required this.authProvider});

  // final contactController = Get.find<ContactController>();

  var channel = null;

  var isThereNewUpdate = false.obs;

  var newAppVersion = ''.obs;
  var newAppDesc = ''.obs;
  var mustUpdate = false.obs;
  var appleAppId = ''.obs;

  int getIndex() => index.value;
  bool isSelected(int index) => index == this.index.value;

  void setIsLoading(bool value) => isLoading.value = value;
  bool getIsLoading() => isLoading.value;

  void setIsError(bool value) => isError.value = value;
  bool getIsError() => isError.value;

  User? getUser() => user.value;
  void setUser(User? user) => this.user.value = user;
  RxInt passport_status = 5.obs;
  RxInt passport_required = 5.obs;
  void setIsThereNotification(bool value) => isThereNotification.value = value;
  bool getIsThereNotification() => isThereNotification.value;
  final activeLocalAuth = true.obs;
  static final LocalAuthentication _auth = LocalAuthentication();
  bool _authInProgress = false;
  Timer? _pauseTimer;
  ScrollController controllerEditeProfile = ScrollController();
  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print("Error checking biometrics: ${e.message}");
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print("Error getting biometrics: ${e.message}");
      return <BiometricType>[];
    }
  }

  Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      _authInProgress = true;
      final authenticated = await _auth.authenticate(
        localizedReason: 'Scan your fingerprint',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      _authInProgress = false;
      return authenticated;
    } on PlatformException catch (e) {
      _authInProgress = false;
      print("Authentication error: ${e.message} (${e.code})");
      return false;
    }
  }

  RxBool startAuth = false.obs;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      // startAuth.value = false;
      // _pauseTimer!.cancel();
      print("sssssssssssssssss");
      // fromInactive = true;
    } else if (state == AppLifecycleState.paused) {
      initLocalAuth();
      if (activeLocalAuth.isTrue) {
        _pauseTimer = Timer(Duration(seconds: 10), () {
          _pauseTimer = null; // Invalidate the timer after 1 minute
          startAuth.value = true;
          print(startAuth);
        });
      }

      print("qqqqqqqqqqqqqqq");
    } else if (state == AppLifecycleState.resumed) {
      if (activeLocalAuth.isTrue) {
        print("=++++++++${startAuth.value}");
        if (_pauseTimer != null && _pauseTimer!.isActive) {
          // Cancel the timer if it's still active
          startAuth.value = false;
          _pauseTimer!.cancel();
        } else {
          // Proceed with authentication if the timer is not active (meaning more than 1 minute has passed)
          if (startAuth.isTrue) {
            print("================");
            print(_authInProgress);
            if (_authInProgress) {
              _authInProgress = false; // Cancel the ongoing authentication
            } else {
              print("qqqqqqqqqwwwwwwwwwwwwwwwwdddddddddddddddd");
              await _handleAuthentication().then((value) {
                if (value) {
                  return;
                }
              });
            }
          }
        }
      }
    }
  }

  Future<bool> _handleAuthentication() async {
    // _pauseTimer = Timer(Duration(seconds: 3), () {
    //   _pauseTimer = null; // Invalidate the timer after 1 minute
    // });
    await authenticate().then((value) async {
      if (value) {
        startAuth.value = false;
        return value;
        // Get.back();
      } else {
        // print(value);
        Get.back();
        await _handleAuthentication().then((value_) {
          if (value_) {
            startAuth.value = false;

            // break;
          }
          return value;
        });
      }
    });
    return false;
  }

  final reviewService = ReviewService();
  void someUserAction() async {
    // Call this function to request a review
    await reviewService.requestReview();
    print("7687878686877");
    print("7687878686877");
  }

  @override
  void onInit() {
    // _opacityController = AnimationController(
    //   vsync: this,
    //   animationBehavior: AnimationBehavior.preserve,

    //   duration: Duration(milliseconds: 400), // Duration of opacity change
    // );
    // opacityAnimation =
    //     Tween<double>(begin: 1.0, end: 0.2).animate(_opacityController);
    initLocalAuth();
    // setUser(user.value);
    // passport_status.value = getUser()?.passport_status ?? 5;
    WidgetsBinding.instance.addObserver(this);
    checkUpdate();
    someUserAction();
    getUserApi();
    // websocket();
    print("asyd: ${passport_status.value}");
    getAlerts();
    super.onInit();
  }

  void getAlerts() {
    authProvider.getAlerts().then((value) {
      if (value.statusCode == 200) {
        final alertList = AlertList.fromJson(value.body);
        alerts.value = alertList.data ?? [];
        if (alerts.length > 0) {
          showAlerts();
        }
      }
    });
  }

  void showAlerts() {
    for (var alert in alerts.reversed) {
      var now = tz.TZDateTime.now(kuwaitTimezoneLocation);
      if (alert.deleteAt != null) {
        if (now.isAfter(alert.deleteAt!)) {
          continue;
        }
      }

      showAlertDialog(alert.id, alert.title, alert.description);
      return;
    }
  }

  void showAlertDialog(id, title, description) {
    readAlert(id);
    Get.dialog(
      barrierDismissible: !isAlertLoading.value,
      Obx(
        () => WillPopScope(
          onWillPop: () async {
            if ((Get.isDialogOpen ?? false)) {
              Get.close(1);
            }
            return !isAlertLoading.value;
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.images.png.alert.image(
                                width: 135.w,
                                // height: 120.h,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            title ?? '',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            constraints: BoxConstraints(
                              maxHeight: 350.h,
                            ),
                            child: Scrollbar(
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                child: HtmlWidget(
                                  description ?? '',
                                  factoryBuilder: () => MyHtmlWidgetFactory(),
                                  onTapUrl: (url) async {
                                    if (await canLaunchUrl(Uri.parse(url))) {
                                      return await launchUrl(
                                        Uri.parse(url),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    } else {
                                      return false;
                                      // throw 'Could not launch $url';
                                    }
                                  },
                                  textStyle: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Text(
                          //   description ?? '',
                          //   style: TextStyle(
                          //     fontSize: 11.sp,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          //   textAlign: TextAlign.center,
                          // ),
                          SizedBox(height: 30.h),
                          //Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isAlertLoading.value
                                  ? SizedBox(
                                      width: 10.w,
                                      height: 10.h,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    )
                                  : Expanded(
                                      child: Container(
                                        // margin: EdgeInsets.only(
                                        //     left: 10.w, right: 10.w, bottom: 10.h),
                                        child: TextButton(
                                          onPressed: () => readAlert(id, true),
                                          style: TextButton.styleFrom(
                                            // minimumSize: const Size.fromHeight(50),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                              SizedBox(width: 10.w),
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
      ),
    );
  }

  void readAlert(id, [bool canClose = false]) {
    isAlertLoading.value = true;
    authProvider.readAlert(id).then((value) {
      isAlertLoading.value = false;
      if ((Get.isDialogOpen ?? false) && canClose) {
        Get.close(1);
      }
    });
  }

  void checkUpdate() {
    authProvider.checkUpdate().then((value) {
      if (value.statusCode == 200) {
        print(value.body);
        final isAndroid = (defaultTargetPlatform == TargetPlatform.android);
        if (value.body['data']['screen'] == 0) {
          disableScreenshotProtection(isAndroid);
        } else {
          enableScreenshotProtection(isAndroid);
        }
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

        isThereNewUpdate.value = checkIsThereNewUpdate(newAppVersion.value);
        if (isThereNewUpdate.value) {
          _showUpdateDiaolog();
        }
      }
    });
  }

  void enableScreenshotProtection(bool isAndroid) async {
    // For Android

    if (isAndroid) {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    } else {
      const platform = MethodChannel('com.example.security');
      try {
        await platform.invokeMethod('enableScreenshotProtection');
      } on PlatformException catch (e) {
        print("Failed to enable screenshot protection: '${e.message}'.");
      }
    }

    // For iOS
  }

  void disableScreenshotProtection(bool isAndroid) async {
    // For Android

    if (isAndroid) {
      await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    } else {
      const platform = MethodChannel('com.example.security');
      try {
        await platform.invokeMethod('disableScreenshotProtection');
      } on PlatformException catch (e) {
        print("Failed to disable screenshot protection: '${e.message}'.");
      }
    }
    // For iOS
  }

  bool checkIsThereNewUpdate(version) {
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

  void _showPassPortDiaolog() {
    print("I am Opeeeeeeeeeeeeeeeeeeeeeeeen");
    Get.dialog(
      barrierDismissible: false,
      WillPopScope(
        onWillPop: () async {
          return false;
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
                          'acction_requird'.tr,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          'passprot_requird'.tr,
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
                                    Get.back(closeOverlays: true);

                                    Get.toNamed(Routes.EDIT_PROFILE);
                                    _scrollToMiddle();
                                    setIndex(4);
                                    // OpenStore.instance.open(
                                    //   appStoreId: appleAppId
                                    //       .value, // AppStore id of your app for iOS
                                    //   androidAppBundleId:
                                    //       'com.fundbucks.app', // Android app bundle package name
                                    // );
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
                                      'upload_passport'.tr,
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

  void websocket() {
    print("121212121212121");
    LaravelEcho.init(token: presistentData.getAuthToken()!);
    print("121212121212121");
  }

  updateToken() async {
    await FirebaseMessaging.instance.getToken().then((value) async {
      print('FCM Token: $value');
      // setFcmToken(value ?? '');
      presistentData.writeFcmToken(value!);
      // final userProvider = Get.put(UserProvider());

      authProvider.update_tokenUser({"fcm_token": value}).then((value) {
        if (value.statusCode == 200) {
          print("dooooooooooooooooooooon");
        } else {
          print("oppps");
        }
      });
    });
  }

  void getUserApi() {
    setIsLoading(true);
    final authToken = presistentData.getAuthToken();
    authProvider.getUser().then((value) {
      // Handle if the token is expired
      setIsLoading(false);
      print("999999999999999999o");
      print(value.statusCode);
      print("999999999999999999o");
      if (value.statusCode == 200) {
        // final baseSuccessModel = BaseSuccessModel.fromJson(value.body);
        // print(baseSuccessModel);
        // EditProfileController editProfileController = Get.find();
        try {
          final User? user = User.fromJson(value.body);
          print("yuyuy");
          if (user != null) {
            passport_status.value = user.passport_status!;
            passport_required.value = user.passport_required!;

            log("User Api: ${user}");
            print("ppp:${passport_status.value}");
            print("rrr:${passport_required.value}");
            if (passport_status.value == 0) {
              SnackBarWidgetAwesomeWarning(
                "passport_update".tr,
                "passport_update_massage".tr,
                ontap: () {
                  setIndex(4);
                  Get.toNamed(Routes.EDIT_PROFILE);
                  _scrollToMiddle();
                },
              );
            } else if (passport_status.value == 3) {
              SnackBarWidgetAwesomeError(
                "passport_rejetced".tr,
                "passport_rejetced_massage".tr,
                ontap: () {
                  // Get.find<ProfileController>().setIndex(4);
                  Get.toNamed(
                    Routes.EDIT_PROFILE,
                  );
                  _scrollToMiddle();
                },
              );
            }

            // editProfileController.updateToken();
            if (passport_required.value == 1 &&
                (user.passport_status == 0 || user.passport_status == 3)) {
              _showPassPortDiaolog();
            }
            print("-----------------------");
            print(user);
            print("-----------------------");
            setUser(user);
            updateToken();
            getIsThereNewNotification();
            websocket();
            listenUserUpdateChannel();
          }
          setIsError(false);
        } catch (e) {
          print("111111111111111111");
          print(e);
          print("111111111111111111");
          setIsError(true);
          return;
        }

        // Get.showSnackbar(GetSnackBar(
        //   title: 'success'.tr,
        //   message: 'success'.tr,
        //   duration: const Duration(seconds: 2),
        // ));
      } else if (value.statusCode == 401) {
        setIsError(true);
        // final baseErrorModel = BaseErrorModel.fromJson(value.body);
        // print(baseErrorModel);
        presistentData.writeAuthToken('');

        SnackBarWidgetAwesome('fail'.tr, 'fail'.tr, ontap: getUserApi);
        // Get.showSnackbar(GetSnackBar(
        //   title: 'fail'.tr,
        //   message: 'fail'.tr,
        //   duration: const Duration(seconds: defaultSnackbarDuration),
        //   mainButton: Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 10.w),
        //     child: ElevatedButton.icon(
        //       onPressed: getUserApi,
        //       icon: Icon(Icons.refresh_outlined),
        //       label: Text('reload'.tr),
        //     ),
        //   ),
        // ));
        Get.offAndToNamed('/login');
      } else {
        setIsError(true);
        SnackBarWidgetAwesome(
          'fail'.tr,
          'something_happened'.tr,
        );
        // Get.showSnackbar(GetSnackBar(
        //   title: 'fail'.tr,
        //   message: 'something_happened'.tr,
        //   duration: const Duration(seconds: defaultSnackbarDuration),
        //   mainButton: ElevatedButton.icon(
        //     onPressed: () {},
        //     icon: Icon(Icons.refresh_outlined),
        //     label: Text('reload'.tr),
        //   ),
        // ));
      }
    });
  }

  void _scrollToMiddle() {
    // Ensure the ScrollController is attached to a scroll view
    if (controllerEditeProfile.hasClients) {
      final middlePosition =
          controllerEditeProfile.position.maxScrollExtent / 1.2;
      controllerEditeProfile.animateTo(
        middlePosition,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    } else {
      // Retry if not yet attached
      Future.delayed(Duration(milliseconds: 100), _scrollToMiddle);
    }
  }

  void listenUserUpdateChannel() {
    Channel channelNew =
        LaravelEcho.pusherClient.subscribe('private-user.${getUser()?.id}');
    channel = channelNew;

    channelNew.bind("user.updated", (PusherEvent? event) {
      if (event?.data != null) {
        _handleNewUserUpdate(event!.data);
      }
    });

    channelNew.bind("user.wallet.updated", (PusherEvent? event) {
      if (event?.data != null) {
        _handleNewUserWalletUpdate(event!.data);
      }
    });

    channelNew.bind("chart.updated", (PusherEvent? event) {
      if (event?.data != null) {
        print(event?.data);
        _handleChartUpdate();
        // _handleNewUserUpdate(event!.data);
      }
    });

    channelNew.bind("update.tickets", (PusherEvent? event) {
      if (event?.data != null) {
        print(event?.data);
        _handleUpdateTickets();
        // _handleNewUserUpdate(event!.data);
      }
    });

    channelNew.bind("close.ticket", (PusherEvent? event) {
      if (event?.data != null) {
        print(event?.data);
        _handleCloseTicket();
        // _handleNewUserUpdate(event!.data);
      }
    });

    channelNew.bind("update.operations", (PusherEvent? event) {
      if (event?.data != null) {
        print(event?.data);
        _handleUpdateOperations();
        // _handleNewUserUpdate(event!.data);
      }
    });

    channelNew.bind("update.reports", (PusherEvent? event) {
      if (event?.data != null) {
        print(event?.data);
        _handleUpdateReports();
        // _handleNewUserUpdate(event!.data);
      }
    });

    channelNew.bind("send.alert", (PusherEvent? event) {
      if (event?.data != null) {
        print(event?.data);
        _handleSendAlert(event?.data);
        // _handleNewUserUpdate(event!.data);
      }
    });
  }

  Channel getChannel() => channel;

  void _handleSendAlert(data) {
    final json = jsonDecode(data);
    final alert = Alert.fromJson(json);
    showAlertDialog(alert.id, alert.title, alert.description);
  }

  void _handleUpdateReports() {
    final reportsController = Get.find<ReportController>();
    if (reportsController.initialized) {
      reportsController.getReports();
    }
  }

  void _handleUpdateOperations() {
    final operationController = Get.find<OperationController>();
    if (operationController.initialized) {
      operationController.getOperations();
    }
  }

  void _handleUpdateTickets() {
    final contactController = Get.find<ContactController>();
    if (contactController.initialized) {
      contactController.getOpenTicket();
    }
  }

  void _handleCloseTicket() {
    final contactController = Get.find<ContactController>();
    if (contactController.initialized) {
      contactController.getAllTickets();
    }
  }

  void _handleChartUpdate() {
    final accountController = Get.find<AccountController>();
    if (accountController.initialized) {
      accountController.getHomePageData(
        accountController.getChoice().toString(),
      );
    }
  }

  void _handleNewUserUpdate(data) {
    final json = jsonDecode(data);

    final user = User.fromJson(json['user']);

    setUser(user);
    if (getUser()?.isBanned == 1) {
      presistentData.writeAuthToken('');

      SnackBarWidgetAwesome(
        'banned'.tr,
        'banned_details'.tr,
      );
      // Get.showSnackbar(GetSnackBar(
      //   title: 'banned'.tr,
      //   message: 'banned_details'.tr,
      //   duration: const Duration(seconds: defaultSnackbarDuration),
      // ));
      Get.offNamedUntil('/login', ModalRoute.withName('newlogin'));
    }
  }

  void _handleNewUserWalletUpdate(data) {
    final json = jsonDecode(data);

    var newJson = jsonEncode({
      'chart': null,
      'wallet': json['chart'],
    });

    final chart = Chart.fromJson(jsonDecode(newJson));
    print(chart);
    final accountController = Get.find<AccountController>();
    accountController.setChartWallet(chart.wallet ?? []);
  }

  void getIsThereNewNotification() {
    authProvider.isThereNotification().then((value) {
      if (value.statusCode == 200) {
        print(value.body['data'].runtimeType);
        setIsThereNotification(value.body['data'] as bool);
      }
    });
  }

  void initLocalAuth() {
    if (presistentData.getLocalAuth() == null) {
      presistentData.writeLocalAuth(true);
      activeLocalAuth.value = true;
      return;
    }
    if (presistentData.getLocalAuth()!) {
      activeLocalAuth.value = true;
      return;
    }
    activeLocalAuth.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    try {
      LaravelEcho.instance.disconnect();
    } catch (e) {}
  }

  navigatePage(index) {
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 800),
        curve: Curves.fastEaseInToSlowEaseOut);
  }

  List<Widget> allScreens = [
    AccountPageView(
        // key: Key("0"),
        ),
    // Container(
    //   child: LoadingLogoWidget(),
    // ),
    ReportPageView(
        // key: Key("1"),
        ),
    OperationPageView(
        // key: Key("2"),
        ),
    ContactPageView(
        // key: Key("3"),
        ),
    // SizedBox(),
    // SizedBox(),
    ProfilePageView(
        // key: Key("4"),
        ),
  ];

  void setIndex(value) {
    // previousIndex.value = index.value;
    // index.value = newIndex;
    // Start the opacity animation
    // if (index.value != value) {
    //   _opacityController.forward().then((_) {
    //     // Once opacity reaches 0, jump to the page
    //     pageController.jumpToPage(value);

    //     // Reset opacity back to 1 after jump
    //     _opacityController.reverse();
    //   });
    // } else {}

    pageController.animateToPage(value,
        duration: Duration(milliseconds: 800),
        curve: Curves.fastEaseInToSlowEaseOut);
    index.value = value;
    if (value == 3) {
      final contactController = Get.find<ContactController>();
      if (contactController.checkIfTheresANewMessage()) {
        contactController.setIndex(1);
        // TODO: Open the ticket page if the message on one ticket
        if (contactController.checkIfMultiTicketMessages()) return;
        final index = contactController.getNewTicketHaveMessage();
        if (index == -1) return;

        final ticket = contactController.getTicket(index);
        if (ticket == null) return;

        Get.toNamed('/ticket', arguments: [
          index, // 0
          'ticket'.trParams({'id': ticket.ticket!}), // 1
          ticket.name, // 2
          ticket.subject, // 3
          intl.DateFormat('yyyy-MM-dd h:m a')
              .format(
                  ticket.createdAt ?? tz.TZDateTime.now(kuwaitTimezoneLocation))
              .toString(), // 4
          false, // 5
          ticket.status, // 6
        ]);
      }
    }
  }
}
