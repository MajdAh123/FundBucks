import 'package:app/app/data/models/models.dart';
import 'package:app/app/modules/create_account/controllers/create_account_controller.dart';
import 'package:app/app/modules/personal_information/providers/user_provider.dart';
import 'package:app/app/modules/portfolio_information/controllers/portfolio_information_controller.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PersonalInformationController extends GetxController {
  final UserPersonalProvider userProvider;

  var isLoading = false.obs;
  var agreeToTerms = false.obs;

  final globalFormKey = GlobalKey<FormState>().obs;

  final phoneNumberController = TextEditingController().obs;

  var genderSelect = ''.obs;

  final countryTextFieldController = FlCountryCodePicker(
    localize: true,
    showSearchBar: false,
  );

  final countryTextEditController = TextEditingController().obs;

  final firstnameTextEditController = TextEditingController().obs;
  final lastnameTextEditController = TextEditingController().obs;
  final emailTextEditController = TextEditingController().obs;
  final cityTextEditController = TextEditingController().obs;

  var countryName = ''.obs;
  var countryCode = ''.obs;
  var countryDialCode = ''.obs;

  var errorText = ''.obs;

  PersonalInformationController({required this.userProvider});

  void setIsLoading(bool isLoading) => this.isLoading.value = isLoading;

  bool getIsLoading() => isLoading.value;

  void setAgreeToTerms(bool? value) {
    this.agreeToTerms.value = value ?? false;
    errorText.value = '';
  }

  getFormKey() => globalFormKey.value;

  void setGenderSelect(String? value) {
    genderSelect.value = value ?? '';
  }

  String? getGenderSelect() =>
      genderSelect.value.isEmpty ? null : genderSelect.value;

  showCountryModal() async {
    final code = await countryTextFieldController
        .showPicker(
      context: Get.context!,
      scrollToDeviceLocale: false,
      backgroundColor: ThemeController.to.getIsDarkMode
          ? containerColorDarkTheme
          : containerColorLightTheme,
      initialSelectedLocale: 'SA',
    )
        .then((value) {
      Get.focusScope?.unfocus();
      return value;
    });
    countryName.value = code?.name ?? '';
    countryCode.value = code?.code ?? '';
    countryDialCode.value = code?.dialCode ?? '';
    if (code != null) {
      print(code.dialCode);
      // String phoneNumber = '+234 500 500 5005';
      // PhoneNumber number =
      //     await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber);
      // String parsableNumber = number.parseNumber();
      // phoneNumberController.value.text = code.dialCode;
    }

    Get.focusScope?.unfocus();
  }

  void onContinueButtonClick() {
    print(phoneNumberController.value.text);

    if (!agreeToTerms.value) {
      errorText.value = 'must_agree_to_terms'.tr;
    }
    if (getFormKey().currentState.validate() && agreeToTerms.value) {
      errorText.value = '';
      insertUser();
      // Get.toNamed('/home');
    }
  }

  @override
  void onInit() {
    super.onInit();
    ever(countryName, (callback) {
      countryTextEditController.value.text = callback;
    });
  }

  void insertUser() {
    setIsLoading(true);
    final createAccountController = Get.find<CreateAccountController>();
    final portfolioController = Get.find<PortfolioInformationController>();

    final FormData _formData = FormData({
      'image': createAccountController.getFile().path.isEmpty
          ? null
          : MultipartFile(createAccountController.getFile(),
              filename: 'fundbucks.jpg'),
      'username':
          createAccountController.usernameTextEditingController.value.text,
      'password':
          createAccountController.passwordTextEditingController.value.text,
      'plan_id': portfolioController.plan.value.id,
      'currency_id': portfolioController.currency.value.id,
      'firstname': firstnameTextEditController.value.text,
      'lastname': lastnameTextEditController.value.text,
      'email': emailTextEditController.value.text,
      'country_code': countryCode.value,
      'gender': genderSelect.value.compareTo('male') == 0 ? 'm' : 'f',
      'city': cityTextEditController.value.text,
      'mobile': phoneNumberController.value.text,
    });

    print('CountryCode: ${countryName.value}');

    userProvider.postUser(_formData).then((value) {
      setIsLoading(false);
      print(value.body);
      print(value.statusCode);
      if (value.statusCode == 200) {
        final baseSuccessModel = BaseSuccessModel.fromJson(value.body);
        print(baseSuccessModel);
        Get.showSnackbar(GetSnackBar(
          title: 'success'.tr,
          message: 'registered_successfully'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
        ));
        // Get.offUntil('/login');
        Get.offNamedUntil('/login', ModalRoute.withName('toNewLogin'),
            arguments: [
              createAccountController.usernameTextEditingController.value.text,
              createAccountController.passwordTextEditingController.value.text
            ]);

        // Timer(Duration(milliseconds: 300),
        //     () => Get.delete<MainPageController>());
      } else if (value.statusCode == 405) {
        final baseErrorModel = BaseErrorModel.fromJson(value.body);
        Get.showSnackbar(GetSnackBar(
          title: 'fail'.tr,
          message: 'email_already_taken'.tr,
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
