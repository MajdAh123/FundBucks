import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app/app/modules/find_account/providers/find_account_provider.dart';

class FindAccountController extends GetxController {
  final FindAccountProvider findAccountProvider;

  FindAccountController({
    required this.findAccountProvider,
  });

  final globalFormKey = GlobalKey<FormState>().obs;
  var isLoading = false.obs;

  final usernameOrEmailTextEditingController = TextEditingController().obs;

  getFormKey() => globalFormKey.value;

  String getUsernameOrEmail() =>
      usernameOrEmailTextEditingController.value.text;

  void setIsLoading(bool value) => isLoading.value = value;
  bool getIsLoading() => isLoading.value;

  void onContinueButtonClick() {
    if (getFormKey().currentState.validate()) {
      findAccount();
    }
  }

  void findAccount() {
    setIsLoading(true);
    final FormData _formData = FormData({
      'usernameOrEmail': getUsernameOrEmail(),
    });
    findAccountProvider.findAccount(_formData).then((value) {
      setIsLoading(false);
      if (value.statusCode == 200) {
        var email = value.body['data'] as String;
        print(email);
        Get.offAndToNamed('/verify', arguments: [email, true]);
        // TODO: Navigate to verify
      }
      if (value.statusCode == 404) {
        Get.showSnackbar(GetSnackBar(
          title: 'error'.tr,
          message: 'account_not_found'.tr,
          duration: Duration(seconds: defaultSnackbarDuration),
        ));
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
