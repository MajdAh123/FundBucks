import 'dart:async';
import 'dart:developer';
import 'package:r_get_ip/r_get_ip.dart';

import 'package:app/app/data/data.dart';
import 'package:app/app/data/models/models.dart';
import 'package:app/app/modules/login/providers/user_provider.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:get_ip_address/get_ip_address.dart';
import 'package:open_store/open_store.dart';
import 'package:timezone/timezone.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/snack_Bar_Awesome_widget.dart';

class LoginController extends GetxController {
  final globalFormKey = GlobalKey<FormState>().obs;
  var deviceInfoPlugin = DeviceInfoPlugin().obs;
  var deviceIp = ''.obs;
  var deviceType = ''.obs;

  var tooManyAttempts = false.obs;
  var saveLogin = false.obs;
  var createAccountChoice = true.obs;

  Timer? _timer;
  var remainSeconds = 0.obs;
  final time = '00.00'.obs;

  void setSaveLogin(bool? save) => this.saveLogin.value = save!;
  bool getSaveLogin() => this.saveLogin.value;

  void setCreateAccountChoice(bool value) => createAccountChoice.value = value;
  bool getCreateAccountChoice() => createAccountChoice.value;

  void setTooManyAttempts(bool? value) => tooManyAttempts.value = value!;
  bool getTooManyAttempts() => tooManyAttempts.value;

  final usernameOrEmailTextEditingController = TextEditingController().obs;
  final passwordTextEditingController = TextEditingController().obs;
  var isLoading = false.obs;
  final presistentData = PresistentData();

  getFormKey() => globalFormKey.value;

  void setIsLoading(bool value) => isLoading.value = value;
  bool getIsLoading() => isLoading.value;

  String getUsernameOrEmail() =>
      usernameOrEmailTextEditingController.value.text;
  String getPassword() => passwordTextEditingController.value.text;

  String getDeviceIp() => deviceIp.value;
  void setDeviceIp(String value) => deviceIp.value = value;

  String getDeviceType() => deviceType.value;
  void setDeviceType(String value) => deviceType.value = value;

  final UserProvider userProvider;
  LoginController({
    required this.userProvider,
  });

  final obscureInput = true.obs;

  var isThereNewUpdate = false.obs;

  var newAppVersion = ''.obs;
  var newAppDesc = ''.obs;
  var mustUpdate = false.obs;
  var appleAppId = ''.obs;

  setObscureInput() => obscureInput.value = !obscureInput.value;

  @override
  void onInit() {
    getDeviceInfo();
    initArgs();
    initTooManyAttempts();
    getRememberMe();
    setData();
    super.onInit();
  }

  _startTimer(int seconds) {
    if (_timer?.isActive ?? false) {
      return;
    }
    const duration = Duration(seconds: 1);
    remainSeconds.value = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainSeconds == 0) {
        presistentData.writeTooManyAttempts('');
        timer.cancel();
        if (Get.isDialogOpen ?? false) {
          Get.back(closeOverlays: true);
        }
        setTooManyAttempts(false);
      } else {
        int minutes = remainSeconds.value ~/ 60;
        int seconds = remainSeconds.value % 60;
        time.value = minutes.toString().padLeft(2, "0") +
            ":" +
            seconds.toString().padLeft(2, "0");
        remainSeconds--;
      }
    });
  }

  void initArgs() {
    if (Get.arguments != null) {
      log(Get.arguments.toString());
      if (Get.arguments[0] != null && Get.arguments[0] is bool) {
        createAccountChoice.value = Get.arguments[0];
      } else {
        log(Get.arguments.toString());
        usernameOrEmailTextEditingController.value.text = Get.arguments[0];
        passwordTextEditingController.value.text = Get.arguments[1];
      }
    }
  }

  void setUsernameAndPasswordTextEditing(username, password) {
    log("username: $username, password: $password");
    usernameOrEmailTextEditingController.value.text = username;
    passwordTextEditingController.value.text = password;
  }

  void getRememberMe() {
    if (presistentData.getRememberMe() != null) {
      if (presistentData.getRememberMe()!) {
        final username = presistentData.getUsername();
        final password = presistentData.getPassword();
        setSaveLogin(true);
        this.usernameOrEmailTextEditingController.value.text = username ?? '';
        this.passwordTextEditingController.value.text = password ?? '';
      }
    }
  }

  Future<void> getDeviceInfo() async {
    setIsLoading(true);
    var deviceInfo = await deviceInfoPlugin.value.deviceInfo;
    if (deviceInfo is AndroidDeviceInfo) {
      print('android');
      setDeviceType('android');
    } else if (deviceInfo is IosDeviceInfo) {
      print('ios');
      setDeviceType('ios');
    } else {
      print('unknown');
      setDeviceType('unknown');
    }
    try {
      // var ipAddress = IpAddress(type: RequestType.json);
      // dynamic data = await ipAddress.getIpAddress();
      // setDeviceIp(data['ip']);

      var ipAddress = await RGetIp.externalIP;
      setDeviceIp(ipAddress!);
      print(ipAddress);
    } on Exception catch (exception) {
      // setDeviceIp(data['ip']);
      setIsLoading(false);
      print(exception);
    }

    setIsLoading(false);
  }

  void changeLanguage(String lan) {
    final presistentData = PresistentData();
    presistentData.writeLocaleCode(lan);
    print('Lang from controller: ' + presistentData.readLocaleCode()!);
    Get.updateLocale(Locale(lan));
  }

  void changeTheme() {
    final themeController = Get.find<ThemeController>();
    themeController.toggleTheme();
    update();
  }

  void login() {
    setIsLoading(true);
    final FormData _formData = FormData({
      'usernameOrEmail': getUsernameOrEmail(),
      'password': getPassword(),
      'fcm': presistentData.getFcmToken(),
      'ip': getDeviceIp().isEmpty ? null : getDeviceIp(),
      'deviceType': getDeviceType(),
    });

    userProvider.login(_formData).then((value) {
      setIsLoading(false);
      print(value.body);
      if (value.statusCode == 200) {
        final baseSuccessModel = BaseSuccessModel.fromJson(value.body);
        print(baseSuccessModel);
        // Get.showSnackbar(
        SnackBarWidgetAwesome(
          'success'.tr,
          'login_successfully'.tr,
        );
        // );
        // Get.showSnackbar(GetSnackBar(
        //   title: 'success'.tr,
        //   message: 'login_successfully'.tr,
        //   duration: const Duration(seconds: defaultSnackbarDuration),
        // ));

        presistentData.writeAuthToken(baseSuccessModel.data!['token']);
        presistentData.writeRememberMe(getSaveLogin());
        if (getSaveLogin()) {
          presistentData.writeUsername(getUsernameOrEmail());
          presistentData.writePassword(getPassword());
        }

        Get.offAndToNamed('/home');
      } else if (value.statusCode == 201) {
        final baseSuccessModel = BaseSuccessModel.fromJson(value.body);

        SnackBarWidgetAwesome(
          'success'.tr,
          'opt_sent_successfully'.tr,
        );
        // Get.showSnackbar(GetSnackBar(
        //   title: 'success'.tr,
        //   message: 'verify_email_to_login'.tr,
        //   duration: const Duration(seconds: defaultSnackbarDuration),
        // ));
        // Navigate to verify screen
        Get.offAndToNamed('/verify',
            arguments: ['${baseSuccessModel.data!["email"]}', false]);
      } else if (value.statusCode == 404) {
        final baseErrorModel = BaseErrorModel.fromJson(value.body);
        print(baseErrorModel);

        SnackBarWidgetAwesome(
          'fail'.tr,
          'login_failed'.tr,
        );
        // Get.showSnackbar(GetSnackBar(
        //   title: 'fail'.tr,
        //   message: 'login_failed'.tr,
        //   duration: const Duration(seconds: defaultSnackbarDuration),
        // ));
      } else if (value.statusCode == 405) {
        // final baseErrorModel = BaseErrorModel.fromJson(value.body);
        // print(baseErrorModel);

        SnackBarWidgetAwesome(
          'fail'.tr,
          'banned'.tr,
        );
        // Get.showSnackbar(GetSnackBar(
        //   title: 'fail'.tr,
        //   message: 'banned'.tr,
        //   duration: const Duration(seconds: defaultSnackbarDuration),
        // ));
      } else if (value.statusCode == 429) {
        // final baseErrorModel = BaseErrorModel.fromJson(value.body);
        // print(baseErrorModel);
        _startTimer(value.body['data'][0]);
        if (value.body['data'][1] == null) {
          var nowDate = TZDateTime.now(kuwaitTimezoneLocation).toString();
          presistentData.writeTooManyAttempts(nowDate);
          setTooManyAttempts(true);
        }
        _showTooManyAttemptsDialog();

        SnackBarWidgetAwesome(
          'fail'.tr,
          'too_many_attempts'.tr,
        );
        // Get.showSnackbar(GetSnackBar(
        //   title: 'fail'.tr,
        //   message: 'too_many_attempts'.tr,
        //   duration: const Duration(seconds: defaultSnackbarDuration),
        // ));
      } else {
        SnackBarWidgetAwesome(
          'fail'.tr,
          'something_happened'.tr,
        );
        // Get.showSnackbar(GetSnackBar(
        //   title: 'fail'.tr,
        //   message: 'something_happened'.tr,
        //   duration: const Duration(seconds: defaultSnackbarDuration),
        // ));
      }
    });
  }

  void checkUpdate() {
    userProvider.checkUpdate().then((value) {
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

        isThereNewUpdate.value = checkIsThereNewUpdate(newAppVersion.value);
        if (isThereNewUpdate.value) {
          _showUpdateDiaolog();
        }
      }
    });
  }

  bool checkIsThereNewUpdate(version) {
    return appVersion.compareTo(version) != 0;
  }

  void initTooManyAttempts() {
    var data = presistentData.getTooManyAttempts();
    if (data != null && data.isNotEmpty) {
      var date = TZDateTime.parse(kuwaitTimezoneLocation, data);
      var nowDate = TZDateTime.now(kuwaitTimezoneLocation);
      var afterDate = date.add(Duration(minutes: 60));
      remainSeconds.value = (afterDate.difference(nowDate).inSeconds);
      print(remainSeconds.value);
      if (nowDate.difference(date).inHours >= 1) {
        presistentData.writeTooManyAttempts('');
        if (Get.isDialogOpen ?? false) {
          Get.back(closeOverlays: true);
        }
        return;
      }
      setTooManyAttempts(true);
      _startTimer(remainSeconds.value);
    }
  }

  void _showTooManyAttemptsDialog() {
    Get.dialog(
      barrierDismissible: !getTooManyAttempts(),
      WillPopScope(
        onWillPop: () async {
          return !getTooManyAttempts();
        },
        child: Obx(
          () => Column(
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
                            'exceeded_attempts'.tr,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            getTooManyAttempts()
                                ? 'seem_like_you_need_help_non_user'.tr
                                : 'seem_like_you_need_help_user'.tr,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4.h),
                          SelectableLinkify(
                            onOpen: (link) async {
                              if (await canLaunchUrl(Uri.parse(link.url))) {
                                await launchUrl(Uri.parse(link.url));
                              } else {
                                throw 'Could not launch $link';
                              }
                            },
                            text: "support@fundbucks.com",
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            time.value,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          // support@fundbucks.com
                          SizedBox(height: 30.h),
                          //Buttons
                          getTooManyAttempts()
                              ? SizedBox.shrink()
                              : Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: TextButton(
                                          onPressed: () {
                                            if (Get.isDialogOpen ?? false) {
                                              Get.back(closeOverlays: true);
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            backgroundColor:
                                                ThemeController.to.getIsDarkMode
                                                    ? mainColorDarkTheme
                                                    : mainColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              'close'.tr,
                                              style: TextStyle(
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
        ),
      ),
    );
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
                                            Get.close(1);
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
                                              color: mainColor,
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

  void onContinueButtonClick() {
    if (getFormKey().currentState.validate()) {
      login();
      // Get.toNamed('/home');
    }
  }

  void setData() {
    if (Get.arguments != null) {
      if (Get.arguments.length > 1) {
        usernameOrEmailTextEditingController.value.text = Get.arguments[0];
        passwordTextEditingController.value.text = Get.arguments[1];
      }
    }
  }

  @override
  void onReady() {
    if (getTooManyAttempts()) {
      _showTooManyAttemptsDialog();
    }
    super.onReady();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }
}
