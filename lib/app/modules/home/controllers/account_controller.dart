import 'dart:async';

import 'package:app/app/data/models/models.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/home/providers/account_page_provider.dart';
import 'package:app/app/utils/colors.dart';
import 'package:app/app/utils/extension.dart';
import 'package:app/app/utils/functions.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  final AccountPageProvider accountPageProvider;
  late final Timer _timer;

  AccountController({
    required this.accountPageProvider,
  });

  final homeController = Get.find<HomeController>();
  var stock = Stocks().obs;
  var chart = Chart().obs;

  var choice = 0.obs;

  var isLoadingChart = false.obs;

  void setStock(value) => stock.value = value;
  Stocks? getStock() => stock.value;

  void setChart(value) => chart.value = value;
  Chart? getChart() => chart.value;

  void setChoice(int value) => choice.value = value;
  int getChoice() => choice.value;

  void setChartWallet(List<Wallet> value) {
    var chart = getChart();
    chart?.wallet = value;
    setChart(chart);
    update();
  }

  Gold? getGold() => getStock()?.gold;
  Oil? getOil() => getStock()?.oil;
  Dao? getDao() => getStock()?.dao;

  List<AssetModel> getWallets() {
    List<AssetModel> list = [];
    print(getChart()?.wallet?.length);
    if (getChart()?.wallet?.length == 0 ||
        getChart()?.wallet?.length == 1 ||
        getChart()?.wallet == null ||
        homeController.getUser()?.pauseCalc == 1) {
      return [
        AssetModel(
          name: 'cash'.tr,
          percent: 1,
          value: homeController.getUser()?.currentValue == 0
              ? double.parse(homeController.getUser()?.balance ?? '0')
              : double.parse(homeController.getUser()?.currentValue ?? '0'),
          color: getCashColor(),
        ),
      ];
    } else {
      for (var wallet in getChart()!.wallet!) {
        if (getChart()!.wallet!.last == wallet) {
          break;
        }
        list.add(AssetModel(
          name: Functions.getTranslate(
              enValue: wallet.data?.enName ?? '',
              arValue: wallet.data?.name ?? ''),
          percent: wallet.newPercent ?? 0,
          value: wallet.value ?? 0,
          color: wallet.data?.pivot?.color?.toColor(),
        ));
      }
    }

    list.sort((a, b) => a.percent.compareTo(b.percent));
    for (var wallet in getChart()!.wallet!) {
      if (getChart()!.wallet!.last == wallet) {
        list.add(AssetModel(
          name: 'cash'.tr,
          percent: wallet.percent ?? 0,
          value: wallet.value ?? 0,
          color: getCashColor(),
        ));
      }
    }

    // list.sort((a, b) => cashColor.value.compareTo(b.color.value));
    update();
    return list;
  }

  Color getCashColor() {
    return homeController.getUser()?.isBankVer == 0
        ? cashColorNonActive
        : cashColor;
  }

  Color getAmountColor(double value) {
    if (value == 0) {
      return unselectedBottomBarItemColor;
    }

    return value > 0 ? successColor : Colors.red;
  }

  dynamic getInvestmentData() {
    if (getChart()?.investmentChart?.investments == null) {
      if (getChoice() == 0) {
        return DaysChartData(
          days: [''],
          totalInvestmentAmount: [0],
          firstDeposit: FirstDeposit(date: null, value: 0),
        );
      } else if (getChoice() == 1) {
        return MonthsChartData(months: [''], totalInvestmentAmount: [0]);
      } else {
        return YearsChartData(years: [''], totalInvestmentAmount: [0]);
      }
    }
    return getChart()?.investmentChart?.investments;
  }

  // ChartData? getWithdrawsData() => getChart()?.investmentChart?.withdraws;

  void setIsLoadingChart(value) => isLoadingChart.value = value;
  bool getIsLoadingChart() => isLoadingChart.value;

  @override
  void onInit() {
    startTimer();
    getHomePageData(getChoice().toString());
    // getStocksApi();
    super.onInit();
    ever(choice, (value) {
      getHomePageData(value.toString());
    });
  }

  void startTimer() {
    getStocksApi();
    _timer = Timer.periodic(Duration(minutes: 1), (_) {
      getStocksApi();
    });
  }

  void getStocksApi() {
    accountPageProvider.getStocks().then((value) {
      print(value.body);
      print(value.statusCode);
      if (value.statusCode == 200) {
        if (value.body.toString().isNotEmpty) {
          final stock = Stocks.fromJson(value.body);
          setStock(stock);
        }
      }
    });
  }

  void getHomePageData(String type) {
    setIsLoadingChart(true);
    accountPageProvider.getHomePageData(type).then((value) {
      print(value.body);
      print(value.statusCode);
      setIsLoadingChart(false);
      if (value.statusCode == 200) {
        if (value.body.toString().isNotEmpty) {
          final chart = Chart.fromJson(value.body);
          print(chart.investmentChart?.investments ?? []);
          setChart(chart);
          update();
        }
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // _ticker.stop(cancel: true);
    _timer.cancel();
  }
}
