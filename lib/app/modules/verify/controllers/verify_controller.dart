import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';

import 'package:app/app/data/data.dart';
import 'package:app/app/data/models/models.dart';
import 'package:app/app/modules/verify/providers/verify_provider.dart';

class VerifyController extends GetxController {
  final VerifyProvider verifyProvider;
  VerifyController({
    required this.verifyProvider,
  });

  final globalFormKey = GlobalKey<FormState>().obs;
  var isLoading = false.obs;
  var isPasswordReset = false.obs;

  var emailOtp = ''.obs;
  var otp = ''.obs;

  final otpTextFieldController = OtpFieldController().obs;

  getFormKey() => globalFormKey.value;

  void setIsLoading(bool value) => isLoading.value = value;
  bool getIsLoading() => isLoading.value;

  void setIsPasswordReset(bool value) => isPasswordReset.value = value;
  bool getIsPasswordReset() => isPasswordReset.value;

  OtpFieldController getOtpTextFieldController() =>
      otpTextFieldController.value;

  void setEmailOtp(String value) => emailOtp.value = value;

  String getEmailOtp() => emailOtp.value;

  void setOtp(String value) => otp.value = value;

  String getOtp() => otp.value;

  @override
  void onInit() {
    setEmailOtp(Get.arguments[0] ?? '');
    setIsPasswordReset(Get.arguments[1] ?? false);

    if (getIsPasswordReset()) {
      sendVerify();
    }
    super.onInit();
  }

  void onContinueButtonClick() {
    getOtpTextFieldController().setFocus(0);
    if (getOtp().length == 6) {
      verify();
    }
  }

  void onSendAgainClick() {
    getOtpTextFieldController().clear();
    sendVerify();
  }

  void verify() {
    print(getIsPasswordReset());
    setIsLoading(true);
    final FormData _formData = FormData({
      'email': getEmailOtp(),
      'ver_code': getOtp(),
      'isPasswordReset': getIsPasswordReset() ? true : null,
    });

    final verifyProvider = Get.find<VerifyProvider>();
    final presistentData = PresistentData();

    verifyProvider.verifyCode(_formData).then((value) {
      setIsLoading(false);
      print(value.body);
      if (value.statusCode == 200) {
        if (getIsPasswordReset()) {
          Get.offAndToNamed('/reset-password', arguments: [getEmailOtp()]);
          return;
        }
        // successfully_verified_account
        Get.showSnackbar(GetSnackBar(
          title: 'success'.tr,
          message: 'successfully_verified_account'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
        ));

        presistentData.writeAuthToken(value.body['data']['token'] as String);
        Get.offAndToNamed('/home');
      } else if (value.statusCode == 405) {
        final baseErrorModel = BaseErrorModel.fromJson(value.body);
        print(baseErrorModel);
        Get.showSnackbar(GetSnackBar(
          title: 'fail'.tr,
          message: 'please_check_email'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
        ));
      } else if (value.statusCode == 404) {
        final baseErrorModel = BaseErrorModel.fromJson(value.body);
        print(baseErrorModel);
        Get.showSnackbar(GetSnackBar(
          title: 'fail'.tr,
          message: 'please_check_opt'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
        ));
      } else {
        Get.showSnackbar(GetSnackBar(
          title: 'fail'.tr,
          message: 'something_happened'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
        ));
      }
    });
  }

  void sendVerify() {
    setIsLoading(true);
    final FormData _formData = FormData({
      'email': getEmailOtp(),
      'isPasswordReset': getIsPasswordReset() ? true : null,
    });

    verifyProvider.sendVerifyCode(_formData).then((value) {
      setIsLoading(false);
      print(value.body);
      getOtpTextFieldController().setFocus(0);

      if (value.statusCode == 200) {
        final baseSuccessModel = BaseSuccessModel.fromJson(value.body);
        print(baseSuccessModel);
        Get.showSnackbar(GetSnackBar(
          title: 'success'.tr,
          message: 'opt_sent_successfully'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
        ));
        // presistentData.writeAuthToken(baseSuccessModel.data!['token']);
        // Get.toNamed('/home');
      } else if (value.statusCode == 405) {
        final baseErrorModel = BaseErrorModel.fromJson(value.body);
        print(baseErrorModel);
        Get.showSnackbar(GetSnackBar(
          title: 'fail'.tr,
          message: 'please_check_email'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
        ));
      } else {
        Get.showSnackbar(GetSnackBar(
          title: 'fail'.tr,
          message: 'something_happened'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
        ));
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
