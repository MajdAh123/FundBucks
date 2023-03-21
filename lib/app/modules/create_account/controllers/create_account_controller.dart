import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:app/app/modules/create_account/providers/create_account_provider.dart';

class CreateAccountController extends GetxController {
  final CreateAccountProvider createAccountProvider;
  CreateAccountController({
    required this.createAccountProvider,
  });

  final globalFormKey = GlobalKey<FormState>().obs;

  final usernameTextEditingController = TextEditingController().obs;
  final passwordTextEditingController = TextEditingController().obs;
  final confirmPasswordTextEditingController = TextEditingController().obs;
  var isObscureText = true.obs;
  var isObscureTextForPasswordConfirmation = true.obs;
  var isUsernameTaken = false.obs;
  var isCheckUsernameLoading = false.obs;
  var filePath = ''.obs;
  var imageFile = File('').obs;

  final ImagePicker _picker = ImagePicker();

  String getFilePath() => filePath.value;

  void setFilePath(String path) => filePath.value = path;

  File getFile() => imageFile.value;

  setImageFilePath(File file) => imageFile.value = file;

  void setIsObscureText() => isObscureText.value = !isObscureText.value;

  bool getIsObscureText() => isObscureText.value;

  getFormKey() => globalFormKey.value;

  void setIsUsernameTaken(value) => isUsernameTaken.value = value;
  bool getIsUsernameTaken() => isUsernameTaken.value;

  void setIsCheckUsernameLoading(value) => isCheckUsernameLoading.value = value;
  bool getIsCheckUsernameLoading() => isCheckUsernameLoading.value;

  void setIsObscureTextForPasswordConfirmation() =>
      isObscureTextForPasswordConfirmation.value =
          !isObscureTextForPasswordConfirmation.value;
  bool getIsObscureTextForPasswordConfirmation() =>
      isObscureTextForPasswordConfirmation.value;

  void showImageSelection() {
    Get.bottomSheet(
      Container(
          // height: 100.h,
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  'from_gallery'.tr,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: this.selectFromGallery,
              ),
              ListTile(
                title: Text(
                  'from_camera'.tr,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: this.selectFromCamera,
              ),
            ],
          )),
      isDismissible: true,
      enableDrag: true,
    );
  }

  void selectFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setFilePath(image.path);
      setImageFilePath(File(getFilePath()));
    }
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
  }

  void selectFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setFilePath(image.path);
      setImageFilePath(File(getFilePath()));
    }
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
  }

  void onContinueButtonClick() {
    if (getFormKey().currentState.validate() &&
        !getIsCheckUsernameLoading() &&
        !getIsUsernameTaken()) {
      print('success');
      Get.toNamed('/portfolio-information');
    }
  }

  bool isUsernameLessThan() {
    return usernameTextEditingController.value.text.length < 6;
  }

  void checkUsername(String value) {
    if (value.length < 6) {
      setIsCheckUsernameLoading(false);
      setIsUsernameTaken(false);
      return;
    }
    setIsCheckUsernameLoading(true);
    final FormData _formData = FormData({
      'username': value,
    });
    createAccountProvider.checkUsername(_formData).then((value) {
      print(value.body);
      setIsCheckUsernameLoading(false);
      if (value.statusCode == 200) {
        setIsUsernameTaken(false);
      }
      if (value.statusCode == 201) {
        setIsUsernameTaken(true);
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    ever(usernameTextEditingController, (value) {
      checkUsername(value.text);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
