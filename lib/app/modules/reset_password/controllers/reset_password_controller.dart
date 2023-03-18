import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app/app/modules/reset_password/providers/reset_password_provider.dart';

class ResetPasswordController extends GetxController {
  final ResetPasswordProvider resetPasswordProvider;
  ResetPasswordController({
    required this.resetPasswordProvider,
  });

  final globalFormKey = GlobalKey<FormState>().obs;
  var isLoading = false.obs;
  final passwordTextEditingController = TextEditingController().obs;
  final confirmPasswordTextEditingController = TextEditingController().obs;
  var isObscureTextForPassword = true.obs;
  var isObscureTextForPasswordConfirmation = true.obs;

  var email = ''.obs;

  getFormKey() => globalFormKey.value;

  void setIsLoading(bool value) => isLoading.value = value;
  bool getIsLoading() => isLoading.value;

  void setIsObscureTextForPassword() =>
      isObscureTextForPassword.value = !isObscureTextForPassword.value;
  bool getIsObscureTextForPassword() => isObscureTextForPassword.value;

  void setIsObscureTextForPasswordConfirmation() =>
      isObscureTextForPasswordConfirmation.value =
          !isObscureTextForPasswordConfirmation.value;
  bool getIsObscureTextForPasswordConfirmation() =>
      isObscureTextForPasswordConfirmation.value;

  void setEmail(value) => email.value = value;
  String getEmail() => email.value;

  void onContinueButtonClick() {
    if (getFormKey().currentState.validate()) {
      resetPassword();
    }
  }

  void resetPassword() {
    setIsLoading(true);
    final FormData _formData = FormData({
      'email': getEmail(),
      'password': passwordTextEditingController.value.text,
    });

    resetPasswordProvider.resetPassword(_formData).then((value) {
      print(value.body);
      setIsLoading(false);
      if (value.statusCode == 200) {
        Get.showSnackbar(GetSnackBar(
          title: 'success'.tr,
          message: 'reset_password_success'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
        ));
        Get.offNamedUntil('/login', ModalRoute.withName('toNewLogin'));
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
  void onInit() {
    setEmail(Get.arguments[0]);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
