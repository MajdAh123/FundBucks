import 'dart:io';
import 'package:app/app/data/presistent/presistent_data.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:app/app/modules/edit_profile/providers/user_provider.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final UserProvider userProvider;

  EditProfileController({
    required this.userProvider,
  });

  ScrollController controller = ScrollController();
  ScrollController scrollController = ScrollController();

  final presistentData = PresistentData();

  final globalFormKey = GlobalKey<FormState>().obs;
  final deleteAccountFormKey = GlobalKey<FormState>().obs;
  final dataKey = GlobalKey();

  var isPhotoLoading = false.obs;
  var isDeleteLoading = false.obs;

  var otherReasonTextEditingController = TextEditingController().obs;

  var deleteAccountCause = 'not_interested'.obs;

  void setIsPhotoLoading(bool value) => isPhotoLoading.value = value;
  bool getIsPhotoLoading() => isPhotoLoading.value;

  void setIsDeleteLoading(value) => isDeleteLoading.value = value;
  bool getIsDeleteLoading() => isDeleteLoading.value;

  var countryDialCode = ''.obs;

  final homeController = Get.find<HomeController>();

  final countryTextFieldController = FlCountryCodePicker(
    localize: true,
    showSearchBar: false,
  );
  
  final countryTextEditController = TextEditingController().obs;

  final passwordTextEditController = TextEditingController().obs;

  final phoneNumberController = TextEditingController().obs;

  final firstNameTextEditController = TextEditingController().obs;
  final lastNameTextEditController = TextEditingController().obs;
  final cityTextEditController = TextEditingController().obs;

  final bankNameTextEditController = TextEditingController().obs;
  final bankAccountNumberTextEditController = TextEditingController().obs;
  final bankAccountNameTextEditController = TextEditingController().obs;
  final bankIbanNumberTextEditController = TextEditingController().obs;

  // var phoneNumberController = PhoneNumberInputController(Get.context!).obs;

  final focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  var filePath = ''.obs;
  var imageFile = File('').obs;

  var isLoading = false.obs;

  var genderSelect = ''.obs;

  getFormKey() => globalFormKey.value;

  final ImagePicker _picker = ImagePicker();

  String getFilePath() => filePath.value;

  void setFilePath(String path) => filePath.value = path;

  File getFile() => imageFile.value;

  setImageFilePath(File file) => imageFile.value = file;

  var countryCode = ''.obs;

  var obscureText = true.obs;

  void setObscureText() => obscureText.value = !obscureText.value;

  void setIsLoading(bool isLoading) => this.isLoading.value = isLoading;

  bool getIsLoading() => isLoading.value;

  showCountryModal() async {
    final code = await countryTextFieldController.showPicker(
      context: Get.context!,
      scrollToDeviceLocale: true,
      backgroundColor: ThemeController.to.getIsDarkMode
          ? containerColorDarkTheme
          : containerColorLightTheme,
      // barrierColor: ThemeController.to.getIsDarkMode
      //     ? containerColorDarkTheme
      //     : containerColorLightTheme,
    );
    countryCode.value = code?.code ?? '';
    countryTextEditController.value.text = code?.name ?? '';
    countryDialCode.value = code?.dialCode ?? '';

    if (code != null) {
      // phoneNumberController.value.selectedCountry =
      //     phoneNumberController.value.getCountryByCountryCode(code.code);
    }

    Get.focusScope?.unfocus();
  }

  getFocusNode(int index) => focusNodes[index];

  void setGenderSelect(String? value) {
    genderSelect.value = value ?? '';
  }

  String? getGenderSelect() =>
      genderSelect.value.isEmpty ? null : genderSelect.value;

  String getEmail() {
    return homeController.getUser()?.email ?? '';
  }

  String getUsername() {
    return homeController.getUser()?.username ?? '';
  }

  String getPortfolioName() {
    return Get.locale?.languageCode.compareTo('ar') == 0
        ? (homeController.getUser()?.plan?.name ?? '')
        : (homeController.getUser()?.plan?.enName ?? '');
  }

  String getPortfolioDescription() {
    return Get.locale?.languageCode.compareTo('ar') == 0
        ? (homeController.getUser()?.plan?.notes ?? '')
        : (homeController.getUser()?.plan?.enNotes ?? '');
  }

  String getPortfolioInterestType() {
    return Get.locale?.languageCode.compareTo('ar') == 0
        ? homeController.getUser()?.plan?.returnType?.name ?? ''
        : homeController.getUser()?.plan?.returnType?.enName ?? '';
  }

  String getPortfolioInterestPercent() {
    return homeController.getUser()?.plan?.interestPercent ?? '';
  }

  String getPortfolioWithdrawDays() {
    return Get.locale?.languageCode.compareTo('ar') == 0
        ? homeController.getUser()?.plan?.withdrawalPeriod?.name ?? ''
        : homeController.getUser()?.plan?.withdrawalPeriod?.enName ?? '';
  }

  String getCurrency() {
    return Get.locale?.languageCode.compareTo('ar') == 0
        ? (homeController.getUser()?.currency?.currencyId ?? '')
        : (homeController.getUser()?.currency?.currencySign ?? '');
  }

  String getGenderValue() {
    switch (homeController.getUser()?.gender) {
      case 'm':
        return 'male';
      case 'f':
        return 'female';
      default:
        return '';
    }
  }

  String getCountryName(String countryCode) {
    CountryCode code = countryTextFieldController.countryCodes.firstWhere(
      (element) => element.code == countryCode,
      orElse: () {
        return countryTextFieldController.countryCodes
            .where((element) => element.code == 'SA')
            .first;
      },
    );
    countryDialCode.value = code.dialCode;
    return code.name;
  }

  void setUserData() {
    setGenderSelect(getGenderValue());
    firstNameTextEditController.value.text =
        homeController.getUser()?.firstname ?? '';
    lastNameTextEditController.value.text =
        homeController.getUser()?.lastname ?? '';
    countryCode.value = homeController.getUser()?.country?.countryCode ?? '';
    countryTextEditController.value.text =
        getCountryName(homeController.getUser()?.country?.countryCode ?? '');
    cityTextEditController.value.text = homeController.getUser()?.city ?? '';

    phoneNumberController.value.text = homeController.getUser()?.mobile ?? '';

    bankNameTextEditController.value.text =
        homeController.getUser()?.bankName ?? '';
    bankAccountNumberTextEditController.value.text =
        homeController.getUser()?.bankUserId ?? '';
    bankAccountNameTextEditController.value.text =
        homeController.getUser()?.bankUsername ?? '';
    bankIbanNumberTextEditController.value.text =
        homeController.getUser()?.iban ?? '';
  }

  bool getIsBankingRequired() {
    return bankNameTextEditController.value.text.isNotEmpty ||
        bankAccountNumberTextEditController.value.text.isNotEmpty ||
        bankAccountNameTextEditController.value.text.isNotEmpty ||
        bankIbanNumberTextEditController.value.text.isNotEmpty;
  }

  void onUpdateButtonClick() {
    if (getFormKey().currentState.validate()) {
      updateUserDate();
    }
  }

  void deleteAccount() {
    if (Get.isDialogOpen ?? false) {
      Get.close(1);
    }
    final FormData _formData = FormData({
      'reason': getDeleteAccountReason(),
    });
    setIsDeleteLoading(true);
    userProvider.deleteAccount(_formData).then((value) {
      setIsDeleteLoading(false);
      print(value.statusCode);
      if (value.statusCode == 200) {
        presistentData.writeAuthToken('');
        Get.offNamedUntil('/login', ModalRoute.withName('toNewLogin'));
      }
    });
  }

  void updateUserDate() {
    setIsLoading(true);
    setIsPhotoLoading(getFile().path.isNotEmpty);
    final FormData _formData = FormData({
      'image': getFile().path.isEmpty
          ? null
          : MultipartFile(getFile(), filename: 'user-avatar.jpg'),
      'password': getTextValue(passwordTextEditController.value.text),
      'firstname': getTextValue(firstNameTextEditController.value.text),
      'lastname': getTextValue(lastNameTextEditController.value.text),
      'gender': genderSelect.value.compareTo('male') == 0 ? 'm' : 'f',
      'country_code': countryCode.value,
      'city': cityTextEditController.value.text,
      'mobile': phoneNumberController.value.text,
      'bank_name': getTextValue(bankNameTextEditController.value.text),
      'bank_account_number':
          getTextValue(bankAccountNumberTextEditController.value.text),
      'bank_account_name':
          getTextValue(bankAccountNameTextEditController.value.text),
      'bank_iban': getTextValue(bankIbanNumberTextEditController.value.text),
    });

    userProvider.updateUser(_formData).then((value) {
      setIsLoading(false);
      setIsPhotoLoading(false);
      print(value.body);
      if (value.statusCode == 200) {
        Get.showSnackbar(GetSnackBar(
          title: 'success'.tr,
          message: 'successfully_update_profile'.tr,
          duration: Duration(seconds: defaultSnackbarDuration),
        ));
        homeController.getUserApi();
        Get.close(1);
      }
    });
  }

  String? getTextValue(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return null;
    }

    return value;
  }

  void onResetAvatarButtonClick() {
    resetAvatar();
  }

  void resetAvatar() {
    setIsLoading(true);
    setIsPhotoLoading(true);
    userProvider.resetAvatar().then((value) {
      setIsLoading(false);
      setIsPhotoLoading(false);
      if (value.statusCode == 200) {
        Get.showSnackbar(GetSnackBar(
          title: 'success'.tr,
          message: 'reset_avatar'.tr,
          duration: Duration(seconds: defaultSnackbarDuration),
        ));
        homeController.getUserApi();
      }
    });
  }

  String getDeleteAccountReason() {
    if (deleteAccountCause.value == 'other') {
      return otherReasonTextEditingController.value.text;
    }
    switch (deleteAccountCause.value) {
      case 'not_interested':
        return 'غير مهتم';
      case 'not_ready_yet':
        return 'غير جاهز حالياً للمشاركة';
      case 'unsatisfactory_service':
        return 'خدمة غير مرضية';
    }
    return '';
  }

  final deleteReasons = [
    {
      'key': 'not_interested',
      'title': 'not_interested'.tr,
    },
    {
      'key': 'not_ready_yet',
      'title': 'not_ready_yet'.tr,
    },
    {
      'key': 'unsatisfactory_service',
      'title': 'unsatisfactory_service'.tr,
    },
    {
      'key': 'other',
      'title': 'other'.tr,
    },
  ];

  bool deleteReasonIsOther() => deleteAccountCause.value == 'other';

  void showDeleteAccountReasonDialog() {
    Get.dialog(
      barrierDismissible: true,
      Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10.h),
                        Text(
                          'delete_cause'.tr,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15.h),
                        // Here is the reasons why the account is being deleted
                        Form(
                          key: deleteAccountFormKey.value,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...deleteReasons.map<Widget>((value) {
                                if (value['key'] == 'other') {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RadioListTile(
                                        value: value['key'],
                                        title: Text(value['title'] ?? ''),
                                        groupValue: deleteAccountCause.value,
                                        onChanged: (value) {
                                          deleteAccountCause.value =
                                              value ?? '';
                                        },
                                      ),
                                      SizedBox(height: 3.h),
                                      !deleteReasonIsOther()
                                          ? SizedBox.shrink()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                cursorColor: mainColor,
                                                textInputAction:
                                                    TextInputAction.done,
                                                controller:
                                                    otherReasonTextEditingController
                                                        .value,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                validator: (otherValue) {
                                                  if ((otherValue?.isEmpty ??
                                                          false) &&
                                                      deleteReasonIsOther()) {
                                                    return 'required_field'
                                                        .trParams({
                                                      'name':
                                                          value['title'] ?? '',
                                                    });
                                                  }
                                                  return null;
                                                },
                                                maxLines: 3,
                                                decoration: InputDecoration(
                                                  errorMaxLines: 2,
                                                  hintText:
                                                      'other_reason_here'.tr,
                                                  filled: true,
                                                  // fillColor: Colors.white,
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    borderSide: BorderSide(
                                                      color: strokeColor,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    borderSide: BorderSide(
                                                      color: strokeColor,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  hintStyle: TextStyle(
                                                    //fontFamily: FontFamily.inter,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    borderSide: BorderSide(
                                                      color: strokeColor,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  );
                                }
                                return RadioListTile(
                                  value: value['key'],
                                  title: Text(value['title'] ?? ''),
                                  groupValue: deleteAccountCause.value,
                                  onChanged: (value) {
                                    deleteAccountCause.value = value ?? '';
                                  },
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                        //Buttons
                        Row(
                          children: [
                            SizedBox(width: 5.w),
                            Expanded(
                              child: Container(
                                child: TextButton(
                                  onPressed: () {
                                    if (deleteAccountFormKey.value.currentState!
                                        .validate()) {
                                      print(deleteAccountFormKey
                                          .value.currentState!
                                          .validate());
                                      if (Get.isDialogOpen ?? false) {
                                        Get.close(1);
                                      }
                                      showDeleteAccountDialog();
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    // minimumSize: const Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    // primary: mainColor,
                                    backgroundColor: Colors.red.shade400,

                                    // backgroundColor:
                                    //     ThemeController.to.getIsDarkMode
                                    //         ? mainColorDarkTheme
                                    //         : mainColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'continue_text'.tr,
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
                                    // Get.clo(1);
                                    if (Get.isDialogOpen ?? false) {
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
                            SizedBox(width: 5.w),
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

  void showDeleteAccountDialog() {
    Get.dialog(
      barrierDismissible: true,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
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
                        'delete_account_desc'.tr,
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
                          SizedBox(width: 5.w),
                          Expanded(
                            child: Container(
                              child: TextButton(
                                onPressed: deleteAccount,
                                style: TextButton.styleFrom(
                                  // minimumSize: const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  // primary: mainColor,
                                  backgroundColor: Colors.red.shade400,
                                ),
                                child: Center(
                                  child: Text(
                                    'delete_account'.tr,
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
                          SizedBox(width: 5.w),
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

  @override
  void onInit() {
    for (var node in focusNodes) {
      node.addListener(() {
        update();
      });
    }

    super.onInit();

    setUserData();

    ever(countryCode, (callback) {
      countryTextEditController.value.text = callback;
    });
  }

  @override
  void onReady() {
    super.onReady();

    if (Get.arguments != null) {
      if (Get.arguments[0] != null) {
        if (Get.arguments[0]) {
          controller.animateTo(controller.position.maxScrollExtent,
              duration: Duration(milliseconds: 700), curve: Curves.easeIn);
          // if (dataKey.currentContext != null) {
          // Scrollable.ensureVisible(GlobalObjectKey('uni').currentContext!);
          // }
        }
      }
    }
  }

  @override
  void onClose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    // phoneNumberController.value.dispose();
  }

  void showImageSelection() {
    Get.bottomSheet(
      Container(
          // height: 100.h,
          color: ThemeController.to.getIsDarkMode
              ? containerColorDarkTheme
              : containerColorLightTheme,
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
}
