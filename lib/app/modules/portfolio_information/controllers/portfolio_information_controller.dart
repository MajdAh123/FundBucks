import 'package:app/app/data/models/models.dart';
import 'package:app/app/modules/portfolio_information/providers/portfolio_provider.dart';
import 'package:app/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PortfolioInformationController extends GetxController {
  final globalFormKey = GlobalKey<FormState>().obs;

  final planDetailsTextEditingController = TextEditingController().obs;
  final planInterestTypeTextEditingController = TextEditingController().obs;
  final planWithdrawDaysTextEditingController = TextEditingController().obs;
  final planExepectedReturnTextEditinController = TextEditingController().obs;

  final PortfolioProvider portfolioProvider;
  var isLoading = true.obs;

  var portfolioSelect = ''.obs;
  var currencySelect = ''.obs;

  var plan = Plan().obs;
  var currency = Currency().obs;

  RxList<Plan> portfolios = <Plan>[].obs;
  RxList<Currency> currencies = <Currency>[].obs;

  PortfolioInformationController({required this.portfolioProvider});

  getFormKey() => globalFormKey.value;

  void setIsLoading(bool value) => isLoading.value = value;

  bool getIsLoading() => isLoading.value;

  String? getPortfolioSelect() =>
      portfolioSelect.value.isEmpty ? null : portfolioSelect.value;
  String? getCurrencySelect() =>
      currencySelect.value.isEmpty ? null : currencySelect.value;

  List<Plan> getPlans() => portfolios;

  List<Currency> getCurrencies() => currencies;

  void setPortfolioSelect(String? value) {
    portfolioSelect.value = value ?? '';
    print(portfolioSelect.value);
    for (var e in getPlans()) {
      var key = Functions.getTranslate(enValue: e.enName!, arValue: e.name!);
      if (portfolioSelect.compareTo(key) == 0) {
        print('er');
        if (getCurrencies().isNotEmpty)
          setCurrencySelect(getCurrencies().first.currencyId);
        plan.value = e;
        planDetailsTextEditingController.value.text = Functions.getTranslate(
          enValue: e.enNotes!,
          arValue: e.notes!,
        );
        planInterestTypeTextEditingController.value.text =
            Get.locale?.languageCode.compareTo('ar') == 0
                ? e.returnType?.name ?? ''
                : e.returnType?.enName ?? '';
        planWithdrawDaysTextEditingController.value.text =
            Get.locale?.languageCode.compareTo('ar') == 0
                ? e.withdrawalPeriod?.name ?? ''
                : e.withdrawalPeriod?.enName ?? '';
        planExepectedReturnTextEditinController.value.text =
            e.interestPercent ?? '';
      }
    }
  }

  void setCurrencySelect(String? value) {
    currencySelect.value = value ?? '';
    for (var e in getCurrencies()) {
      var key = Get.locale?.languageCode.compareTo('ar') == 0
          ? e.currencyId
          : e.currencySign;
      if (e.currencyId!.compareTo(key!) == 0) {
        currency.value = e;
      }
    }
  }

  void setPlan(Plan v) => plan.value = v;

  @override
  void onInit() {
    getPortfolios();
    super.onInit();
  }

  void getPortfolios() {
    setIsLoading(true);
    portfolioProvider.getPortfolio().then((value) {
      if (value.statusCode == 200) {
        final baseSuccessModel = BaseSuccessModel.fromJson(value.body);
        print(baseSuccessModel);

        final createPortfolioModel =
            CreatePortfolio.fromJson(baseSuccessModel.data!);
        portfolios.value = createPortfolioModel.plans ?? [];
        currencies.value = createPortfolioModel.currencies ?? [];
        Get.showSnackbar(GetSnackBar(
          title: 'success'.tr,
          message: 'data_fetched'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
        ));
      }
      setIsLoading(false);
    }, onError: (error, stacktrace) {
      print(error);
    });
  }

  void onContinueButtonClick() {
    if (getFormKey().currentState.validate()) {
      Get.toNamed('/personal-information');
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
