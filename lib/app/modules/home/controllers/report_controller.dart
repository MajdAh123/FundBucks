import 'package:app/app/data/models/models.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:intl/intl.dart' as intl;
import 'package:timezone/standalone.dart' as tz;

import 'package:app/app/modules/home/providers/report_provider.dart';

class ReportController extends GetxController {
  final ReportProvider reportProvider;
  ReportController({
    required this.reportProvider,
  });

  final ScrollController scrollController = ScrollController();

  var isLoading = false.obs;

  final fromTextEditingController = TextEditingController().obs;
  final toTextEditingController = TextEditingController().obs;

  final homeController = Get.find<HomeController>();

  var reportList = <InvestmentReport>[].obs;

  var startDate = ''.obs;
  var endDate = ''.obs;

  var totalDeposits = 0.0.obs;
  var totalWithdraws = 0.0.obs;

  var startInvestment = 0.0.obs;
  var endInvestment = 0.0.obs;

  var investmentDifference = 0.0.obs;

  var investmentPercent = 0.0.obs;

  void setStartDate(String value) => startDate.value = value;
  String getStartDate() => startDate.value;

  void setEndDate(String value) => endDate.value = value;
  String getEndDate() => endDate.value;

  void setTotalDeposits(double value) => totalDeposits.value = value;
  double getTotalDeposits() => totalDeposits.value;

  void setTotalWithdraws(double value) => totalWithdraws.value = value;
  double getTotalWithdraws() => totalWithdraws.value;

  void setStartInvestment(double value) => startInvestment.value = value;
  double getStartInvestment() => startInvestment.value;

  void setEndInvestment(double value) => endInvestment.value = value;
  double getEndInvestment() => endInvestment.value;

  void setInvestmentDifference(double value) =>
      investmentDifference.value = value;
  double getInvestmentDifference() => investmentDifference.value;

  void setInvestmentPercent(double value) => investmentPercent.value = value;
  double getInvestmentPercent() => investmentPercent.value;

  bool getIfInvestmentPositive() =>
      getInvestmentDifference() < 0 ? false : true;

  TextEditingController getFromTextEditingController() =>
      fromTextEditingController.value;
  TextEditingController getToTextEditingController() =>
      toTextEditingController.value;

  void setIsLoading(bool isLoading) => this.isLoading.value = isLoading;
  bool getIsLoading() => isLoading.value;

  var fromDateError = ''.obs;
  var toDateError = ''.obs;
  void setReportList(value) => reportList.value = value;
  List<InvestmentReport> getReportList() => reportList;

  String getUserCurrency() {
    return homeController.getUser()?.currency?.currencySign ?? '';
  }

  void validateFromDate() {
    String value = fromTextEditingController.value.text;
    if (value.isEmpty) {
      fromDateError.value = 'required_field'.trParams({
        'name': 'start_date'.trParams({
          'date': '',
        }),
      });
    } else {
      fromDateError.value = '';
    }
  }

  void validateToDate() {
    String fromDate = fromTextEditingController.value.text;
    String toDate = toTextEditingController.value.text;

    if (toDate.isEmpty) {
      toDateError.value = 'required_field'.trParams({
        'name': 'start_date'.trParams({
          'date': '',
        }),
      });
    } else {
      DateTime from = DateTime.tryParse(fromDate) ?? DateTime.now();
      DateTime to = DateTime.tryParse(toDate) ?? DateTime.now();

      if (!to.isAfter(from)) {
        toDateError.value = 'required_field'.trParams({
          'name': 'end_date'.trParams({
            'date': '',
          }),
        });
        ;
      } else {
        toDateError.value = '';
      }
    }
  }

  bool validateForm() {
    validateFromDate();
    validateToDate();

    return fromDateError.value.isEmpty && toDateError.value.isEmpty;
  }

  void onSearchButtonClick() {
    if (validateForm()) {
      sendReport();
    }
  }

  Color getTextColor(double value) {
    if (value == 0) {
      return Colors.grey;
    }

    return getIfInvestmentPositive() ? activeTextColor : secondaryColor;
  }

  String getDate(String value) {
    return intl.DateFormat(Get.locale?.languageCode.compareTo('ar') == 0
            ? 'yyyy/MM/dd'
            : 'dd/MM/yyyy')
        .format(tz.TZDateTime.parse(
            kuwaitTimezoneLocation, value.replaceAll('/', '-') + ' 00:00:00'))
        .toString();
  }

  Widget getIcon(double value) {
    return value == 0
        ? Iconify(
            Get.locale?.languageCode.compareTo('ar') == 0
                ? Bi.arrow_left_short
                : Bi.arrow_right_short,
            size: 16.h,
            color: getAmountColor(value),
          )
        : Iconify(
            value >= 0 ? Bi.arrow_up_short : Bi.arrow_down_short,
            size: 16.h,
            color: getAmountColor(value),
          );
  }

  Color getAmountColor(double value) {
    if (value == 0) {
      return greyReportText;
    }

    return value > 0 ? activeTextColor : inActiveReportText;
  }

  String getInitialDateText(value) {
    if (Get.locale?.languageCode.compareTo('ar') == 0) {
      return Functions.reverseText(value);
    }
    return value;
  }

  void sendReport() {
    setIsLoading(true);
    final FormData _formData = FormData({
      'start_date': getFromTextEditingController().text,
      'end_date': getToTextEditingController().text,
    });

    reportProvider.getReport(_formData).then((value) {
      print(value.body);

      setIsLoading(false);
      if (value.statusCode == 200) {
        setTotalDeposits((value.body['data']['deposit_sum'] as num).toDouble());
        setTotalWithdraws(
            (value.body['data']['withdraw_sum'] as num).toDouble());
        setStartInvestment(
            (value.body['data']['start_investment'] as num).toDouble());

        setEndInvestment(
            (value.body['data']['end_investment'] as num).toDouble());

        if (tz.TZDateTime.now(kuwaitTimezoneLocation).isSameDay(
            tz.TZDateTime.parse(
                kuwaitTimezoneLocation, getToTextEditingController().text))) {
          print('same day');
          setEndInvestment(
              double.parse(homeController.getUser()?.currentValue ?? '0'));
        }

        if (value.body['data']['deposit_date'] != null) {
          setStartDate(intl.DateFormat('yyyy/MM/dd').format(tz.TZDateTime.parse(
              kuwaitTimezoneLocation,
              value.body['data']['deposit_date'] as String)));
        } else {
          setStartDate(getFromTextEditingController().text);
        }

        setEndDate(getToTextEditingController().text);

        setInvestmentDifference(getEndInvestment() - getStartInvestment());
        if (getStartInvestment() == 0) {
          setInvestmentPercent(0.0);
        } else {
          setInvestmentPercent(((getEndInvestment() - getStartInvestment()) /
                  getStartInvestment()) *
              100);
        }
      }
    });
  }

  void getReports() {
    setIsLoading(true);
    reportProvider.getReports().then((value) {
      setIsLoading(false);
      if (value.statusCode == 200) {
        final reports = InvestmentReportList.fromJson(value.body);
        setReportList(reports.data);
      }
    });
  }

  void scrollToItem() {
    scrollController.animateTo(
      690.h, // Adjust this value to match the position of the item you want to scroll to
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onInit() {
    getReports();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
