import 'dart:developer';
import 'dart:io';

import 'package:app/app/data/models/models.dart';
import 'package:app/app/modules/home/controllers/account_controller.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/home/providers/operation_page_provider.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:colorful_iconify_flutter/icons/logos.dart';

import '../../../widgets/snack_Bar_Awesome_widget.dart';

class OperationController extends GetxController {
  final OperationPageProvider operationPageProvider;

  OperationController({
    required this.operationPageProvider,
  });

  final homeController = Get.find<HomeController>();
  final ScrollController scrollController = ScrollController();

  var gateways = <Gateway>[].obs;

  final selectIndex = 1.obs;
  RxString? selectGatewayIndex = ''.obs;

  var bankName = ''.obs;

  void setGateways(value) => gateways.value = value;
  List<Gateway> getGateways() => gateways;

  void setBankName(String? bankName) => this.bankName.value = bankName ?? '';
  String getBankName() => this.bankName.value;

  // late AnimationController controller;
  // late AnimationController operationController;
  // late Animation<double> animation;

  var isLoading = false.obs;
  var isImageError = false.obs;

  void setIsLoading(bool value) => isLoading.value = value;
  bool getIsLoading() => isLoading.value;

  void setIsImageError(bool value) => isImageError.value = value;
  bool getIsErrorImage() => isImageError.value;

  RxList<Currency> currencies = <Currency>[].obs;
  List<Currency> getCurrencies() => currencies;

  RxList<OperationData> deposits = <OperationData>[].obs;
  List<OperationData> getDepositsList() => deposits;

  RxList<OperationData> withdraws = <OperationData>[].obs;
  List<OperationData> getWithdrawsList() => withdraws;

  void setCurrencySelect(String? value, [bool isDeposit = true]) {
    if (isDeposit) {}
    setDepositCurrencySelect(value ?? '');
    for (var e in getCurrencies()) {
      var key = Get.locale?.languageCode.compareTo('ar') == 0
          ? e.currencyId
          : e.currencySign;
      if (getDepositCurrencySelect()?.compareTo(key!) == 0) {
        currencyDeposit.value = e;
      }
    }
  }

  String getBankNameChoice() {
    if (!checkIfBankingDetailsExists()) {
      return 'please_add_banking_details'.tr;
    }
    return homeController.getUser()?.bankName;
  }

  bool checkIfBankingDetailsExists() =>
      (homeController.getUser()?.bankName != null &&
          homeController.getUser()?.bankName.isNotEmpty &&
          homeController.getUser()?.bankUserId != null &&
          homeController.getUser()?.bankUserId.isNotEmpty &&
          homeController.getUser()?.bankUsername != null &&
          homeController.getUser()?.bankUsername.isNotEmpty &&
          homeController.getUser()?.iban != null &&
          homeController.getUser()?.iban.isNotEmpty);

/* ** Start Deposit Form ** */
  var currencyDeposit = Currency().obs;

  var filePath = ''.obs;
  var imageFile = File('').obs;

  var depositCurrencySelect = ''.obs;
  final depositAmountTextEditingController = TextEditingController().obs;
  final depositDateTextEditingController = TextEditingController().obs;

  void setDepositCurrencySelect(String value) =>
      depositCurrencySelect.value = value;

  String? getDepositCurrencySelect() =>
      depositCurrencySelect.value.isEmpty ? null : depositCurrencySelect.value;

  TextEditingController getDepositAmountTextEditingController() =>
      depositAmountTextEditingController.value;

  TextEditingController getDepositDateTextEditingController() =>
      depositDateTextEditingController.value;

  String getDepositDate() => getDepositDateTextEditingController().text;

  String getDepositAmount() => getDepositAmountTextEditingController().text;
  var withdrawAmountError = ''.obs;
  var withdrawCurrencyError = ''.obs;
  var depositAmountError = ''.obs;
  var depositCurrencyError = ''.obs;
  var depositDateError = ''.obs;

  void validateWithdrawAmount() {
    print(withdrawAmountTextEditingController.value.text);
    String value = withdrawAmountTextEditingController.value.text;
    if (value.isEmpty) {
      withdrawAmountError.value = 'required_field'.trParams({
        'name': 'amount'.tr,
      });
    } else {
      double? parsedValue = double.tryParse(value);
      if (parsedValue == null || parsedValue <= 0) {
        withdrawAmountError.value = 'required_field'.trParams({
          'name': 'amount'.tr,
        });
      } else {
        withdrawAmountError.value = '';
      }
    }
  }

  void validateDepositAmount() {
    String value = getDepositAmount();
    if (value.isEmpty) {
      depositAmountError.value = 'required_field'.trParams({
        'name': 'amount'.tr,
      });
    } else {
      double? parsedValue = double.tryParse(value);
      if (parsedValue == null || parsedValue <= 0) {
        depositAmountError.value = 'required_field'.trParams({
          'name': 'amount'.tr,
        });
      } else {
        depositAmountError.value = '';
      }
    }
  }

  void validateDepositCurrency() {
    if (getDepositCurrencySelect() == null ||
        getDepositCurrencySelect()!.isEmpty) {
      depositCurrencyError.value = 'required_field'.trParams({
        'name': 'currency'.tr,
      });
    } else {
      depositCurrencyError.value = '';
    }
  }

  void validateWithdrawCurrency() {
    if (getDepositCurrencySelect() == null ||
        getDepositCurrencySelect()!.isEmpty) {
      depositCurrencyError.value = 'required_field'.trParams({
        'name': 'currency'.tr,
      });
    } else {
      depositCurrencyError.value = '';
    }
  }

  void validateDepositDate() {
    if (getDepositDate().isEmpty) {
      depositDateError.value = 'required_field'.trParams({
        'name': 'date'.tr,
      });
    } else {
      depositDateError.value = '';
    }
  }

  bool validateDepositForm() {
    validateDepositAmount();
    validateDepositCurrency();
    validateDepositDate();

    return depositAmountError.value.isEmpty &&
        depositCurrencyError.value.isEmpty &&
        depositDateError.value.isEmpty;
  }

  bool validateWithdrawForm() {
    validateWithdrawAmount();
    validateWithdrawCurrency();

    return withdrawAmountError.value.isEmpty &&
        withdrawCurrencyError.value.isEmpty;
  }

  void onDepositSendButtonClick() {
    if (getFile().path.isEmpty) {
      setIsImageError(true);
      return;
    }
    if (validateDepositForm()) {
      if (homeController.getUser()?.type?.compareTo('test') == 0) {
        SnackBarWidgetAwesome(
          'error'.tr,
          'must_disable_test_mode'.tr,
        );
        // Get.showSnackbar(GetSnackBar(
        //   title: 'error'.tr,
        //   message: 'must_disable_test_mode'.tr,
        //   duration: const Duration(seconds: defaultSnackbarDuration),
        // ));
        return;
      }
      sendDepositRequest();
    }
  }

/* ** End Deposit Form ** */

  final withdrawAmountTextEditingController = TextEditingController().obs;
  final withdrawBankTextEditingController = TextEditingController().obs;

  bool checkWithdrawAmount() {
    if (double.parse(withdrawAmountTextEditingController.value.text) < 1)
      return true;
    return checkCashValue() <
        (withdrawAmountTextEditingController.value.text.isEmpty
            ? 0
            : double.parse(withdrawAmountTextEditingController.value.text));
    // return double.parse(homeController.getUser()?.currentValue ?? '0') <
    //     (withdrawAmountTextEditingController.value.text.isEmpty
    //         ? 0
    //         : double.parse(withdrawAmountTextEditingController.value.text));
  }

  double checkCashValue() {
    final accountController = Get.find<AccountController>();
    for (var assetModel in accountController.getWallets()) {
      if (assetModel.name.compareTo('cash'.tr) == 0) {
        return assetModel.value;
      }
    }

    return 0.0;
  }

  void onWithdrawSendButtonClick() {
    if (validateWithdrawForm() && checkIfBankingDetailsExists()) {
      if (homeController.getUser()?.type?.compareTo('test') == 0) {
        SnackBarWidgetAwesome(
          'error'.tr,
          'must_disable_test_mode'.tr,
        );
        // Get.showSnackbar(GetSnackBar(
        //   title: 'error'.tr,
        //   message: 'must_disable_test_mode'.tr,
        //   duration: const Duration(seconds: defaultSnackbarDuration),
        // ));
        return;
      }
      sendWithdrawRequest();
    }
  }

  final ImagePicker _picker = ImagePicker();

  String getFilePath() => filePath.value;

  void setFilePath(String path) => filePath.value = path;

  File getFile() => imageFile.value;

  setImageFilePath(File file) => imageFile.value = file;

  void setIndex(int index) => selectIndex.value = index;
  int getIndex() => selectIndex.value;

  void setSelectedGateway(value) => selectGatewayIndex?.value = value;
  String? getSelectedGatewayIndex() {
    print(selectGatewayIndex?.value);
    return selectGatewayIndex?.value;
  }

  void showImageSelection() {
    setIsImageError(false);
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

  int getSelectedGatewayId() {
    return getGateways().firstWhere(
        (element) => element.alias == getSelectedGatewayIndex(), orElse: () {
      return Gateway(id: 0);
    }).id!;
  }

  int getSelectedGatewayCode() {
    return getGateways().firstWhere(
        (element) => element.alias == getSelectedGatewayIndex(), orElse: () {
      return Gateway(code: 0);
    }).code!;
  }

  void sendDepositRequest() {
    setIsLoading(true);
    final FormData _formData = FormData({
      'image': getFile().path.isEmpty
          ? null
          : MultipartFile(getFile(), filename: 'fundbucks.jpg'),
      'amount': getDepositAmount(),
      'currency': getDepositCurrencySelect()?.compareTo('default') == 0 ||
              getDepositCurrencySelect() == null
          ? null
          : currencyDeposit.value.id,
      'date': getDepositDate(),
      'gateway': getSelectedGatewayId(),
    });

    operationPageProvider.sendDeposit(_formData).then((value) {
      setIsLoading(false);
      print(value.body);

      if (value.statusCode == 200) {
        getDepositAmountTextEditingController().text = '';
        getDepositDateTextEditingController().text = '';
        // setCurrencySelect('');
        setFilePath('');
        setImageFilePath(File(''));

        SnackBarWidgetAwesome(
          'success'.tr,
          'we_recieve_your_order'.tr,
        );
        // Get.showSnackbar(GetSnackBar(
        //   title: 'success'.tr,
        //   message: 'we_recieve_your_order'.tr,
        //   duration: const Duration(seconds: defaultSnackbarDuration),
        // ));
      }
    });
  }

  void sendWithdrawRequest() {
    print(withdrawAmountTextEditingController.value.text);
    setIsLoading(true);
    final FormData _formData = FormData({
      'amount': withdrawAmountTextEditingController.value.text,
      'currency': getDepositCurrencySelect()?.compareTo('default') == 0 ||
              getDepositCurrencySelect() == null
          ? null
          : currencyDeposit.value.id,
      'bank_name': homeController.getUser()?.bankName,
      'bank_account_number': homeController.getUser()?.bankUserId,
      'bank_username': homeController.getUser()?.bankUsername,
      'iban': homeController.getUser()?.iban,
    });
    operationPageProvider.sendWithdraw(_formData).then((value) {
      setIsLoading(false);
      print(value.body);

      if (value.statusCode == 200) {
        withdrawAmountTextEditingController.value.text = '';
        // setCurrencySelect('');

        SnackBarWidgetAwesome(
          'success'.tr,
          'we_recieve_your_order'.tr,
        );
        // Get.showSnackbar(GetSnackBar(
        //   title: 'success'.tr,
        //   message: 'we_recieve_your_order'.tr,
        //   duration: const Duration(seconds: defaultSnackbarDuration),
        // ));
      }
    });
  }

  void getPortfolios() async {
    setIsLoading(true);
    await operationPageProvider.getPortfolio().then((value) {
      log("Get Portfolios sttaus code is : ${value.statusCode}");
      if (value.statusCode == 200) {
        final baseSuccessModel = BaseSuccessModel.fromJson(value.body);
        print(baseSuccessModel);

        final currency = Currency.fromJson(
            baseSuccessModel.data?['currencies'] as Map<String, dynamic>);

        log("Currency: ${currency}");
        currencies.value = [currency];
        print("++++++++++++++++++++++++++++");
        for (var tt in currencies.value) {
          print("${tt.currencyId}" "${tt..currencySign}");
        }
        print("++++++++++++++++++++++++++++");

        // setDepositCurrencySelect(value)
        if (currencies.isNotEmpty) {
          setCurrencySelect(Get.locale?.languageCode.compareTo('ar') == 0
              ? homeController.getUser()?.currency?.currencyId
              : homeController.getUser()?.currency?.currencySign);
        }
        print(homeController.getUser()?.currency?.currencySign);
        print(Get.locale?.languageCode);
        print(getDepositCurrencySelect() == currencies.first.currencySign);
      }
      setIsLoading(false);
    }, onError: (error, stacktrace) {
      print(error);
    });
  }
// no_previous_operations

  void getDeposits() {
    setIsLoading(true);
    operationPageProvider.getDepostis().then((value) {
      setIsLoading(false);
      print(value.body);
      if (value.statusCode == 200) {
        if (value.body['data'] != []) {
          var deposit = Deposit.fromJson(value.body);
          deposits.value = deposit.data!;
        }
      }
    });
  }

  void getWithdraws() {
    setIsLoading(true);
    operationPageProvider.getWithdraws().then((value) {
      setIsLoading(false);
      if (value.statusCode == 200) {
        if (value.body['data'] != []) {
          var withdraw = Withdraw.fromJson(value.body);
          withdraws.value = withdraw.data!;
        }
      }
    });
  }

  void getOperations() {
    getDeposits();
    getWithdraws();
  }

  void clearAllForms() {
    setImageFilePath(File(''));
    setFilePath('');
    getDepositAmountTextEditingController().text = '';
    setDepositCurrencySelect('');
    getDepositDateTextEditingController().text = '';
    withdrawAmountTextEditingController.value.text = '';
  }

  void getGatewaysList() {
    setIsLoading(true);
    operationPageProvider.getGateways().then((value) {
      setIsLoading(false);
      if (value.statusCode == 200) {
        var gatewayList = GatewayList.fromJson(value.body);
        setGateways(gatewayList.data);
        if (getGateways().isNotEmpty) {
          if (getGatewayAlias(101) == null) {
            setSelectedGateway(getGateways().first.alias);
          } else {
            setSelectedGateway(getGatewayAlias(101));
          }
        }
      }
    });
  }

  String? getGatewayAlias(code) {
    return getGateways()
        .firstWhereOrNull((element) => element.code == code)
        ?.alias;
  }

  @override
  void onInit() {
    // controller = AnimationController(
    //   duration: const Duration(seconds: 2),
    //   vsync: this,
    // );
    // operationController = AnimationController(
    //   duration: const Duration(milliseconds: 800),
    //   vsync: this,
    // );
    // animation = Tween(
    //   begin: 0.0,
    //   end: 1.0,
    // ).animate(operationController);
    // operationController.forward();
    // controller.addListener(() {
    //   selectIndex.value = selectIndex.value == 0 ? 1 : 0;
    //   controller.forward();
    //   operationController.reverse(from: 0);
    // });
    getGatewaysList();
    getOperations();
    getPortfolios();

    // getDepositDateTextEditingController().text = 'date'.tr;
    // getDepositDateTextEditingController().text = ;
    super.onInit();
  }

  Widget getIconBasedOnGateway(code) {
    if (code == 100) {
      return Iconify(
        Logos.stripe,
        color: mainColor,
        size: 16,
      );
    } else if (code == 101) {
      return Assets.images.png.wireTransfer.image(
        width: 30.1.w,
        height: 22.79.h,
        // color: Colors.amber,
      );
    }
    return SizedBox.shrink();
  }

  void scrollToItem() {
    scrollController.animateTo(
      700.h, // Adjust this value to match the position of the item you want to scroll to
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // controller.dispose();
    // operationController.dispose();
  }
}
