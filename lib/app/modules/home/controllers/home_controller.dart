import 'dart:convert';
import 'dart:developer';

import 'package:app/app/data/data.dart';
import 'package:app/app/data/models/models.dart';
import 'package:app/app/modules/gateway_detail/views/gateway_detail_view.dart';
import 'package:app/app/modules/home/controllers/account_controller.dart';
import 'package:app/app/modules/home/controllers/contact_controller.dart';
import 'package:app/app/modules/home/controllers/operation_controller.dart';
import 'package:app/app/modules/home/controllers/report_controller.dart';
import 'package:app/app/modules/home/providers/auth_provider.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/laravel_echo/laravel_echo.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:open_store/open_store.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final index = 0.obs;
  final presistentData = PresistentData();

  var isThereNotification = false.obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var isAlertLoading = false.obs;

  var alerts = <Alert>[].obs;

  Rx<User?> user = User().obs;

  final AuthProvider authProvider;

  HomeController({required this.authProvider});

  // final contactController = Get.find<ContactController>();

  var channel = null;

  var isThereNewUpdate = false.obs;

  var newAppVersion = ''.obs;
  var newAppDesc = ''.obs;
  var mustUpdate = false.obs;
  var appleAppId = ''.obs;

  int getIndex() => index.value;
  bool isSelected(int index) => index == this.index.value;

  void setIsLoading(bool value) => isLoading.value = value;
  bool getIsLoading() => isLoading.value;

  void setIsError(bool value) => isError.value = value;
  bool getIsError() => isError.value;

  User? getUser() => user.value;
  void setUser(User? user) => this.user.value = user;

  void setIsThereNotification(bool value) => isThereNotification.value = value;
  bool getIsThereNotification() => isThereNotification.value;

  @override
  void onInit() {
    checkUpdate();
    getUserApi();
    getAlerts();
    super.onInit();
  }

  void getAlerts() {
    authProvider.getAlerts().then((value) {
      if (value.statusCode == 200) {
        final alertList = AlertList.fromJson(value.body);
        alerts.value = alertList.data ?? [];
        if (alerts.length > 0) {
          showAlerts();
        }
      }
    });
  }

  void showAlerts() {
    for (var alert in alerts.reversed) {
      var now = tz.TZDateTime.now(kuwaitTimezoneLocation);
      if (alert.deleteAt != null) {
        if (now.isAfter(alert.deleteAt!)) {
          continue;
        }
      }

      showAlertDialog(alert.id, alert.title, alert.description);
      return;
    }
  }

  void showAlertDialog(id, title, description) {
    readAlert(id);
    Get.dialog(
      barrierDismissible: !isAlertLoading.value,
      Obx(
        () => WillPopScope(
          onWillPop: () async {
            if ((Get.isDialogOpen ?? false)) {
              Get.close(1);
            }
            return !isAlertLoading.value;
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 10.h),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.images.png.alert.image(
                                width: 135.w,
                                // height: 120.h,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            title ?? '',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            constraints: BoxConstraints(
                              maxHeight: 350.h,
                            ),
                            child: Scrollbar(
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                child: HtmlWidget(
                                  description ?? '',
                                  factoryBuilder: () => MyHtmlWidgetFactory(),
                                  onTapUrl: (url) async {
                                    if (await canLaunchUrl(Uri.parse(url))) {
                                      return await launchUrl(
                                        Uri.parse(url),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    } else {
                                      return false;
                                      // throw 'Could not launch $url';
                                    }
                                  },
                                  textStyle: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Text(
                          //   description ?? '',
                          //   style: TextStyle(
                          //     fontSize: 11.sp,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          //   textAlign: TextAlign.center,
                          // ),
                          SizedBox(height: 30.h),
                          //Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isAlertLoading.value
                                  ? SizedBox(
                                      width: 10.w,
                                      height: 10.h,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    )
                                  : Expanded(
                                      child: Container(
                                        // margin: EdgeInsets.only(
                                        //     left: 10.w, right: 10.w, bottom: 10.h),
                                        child: TextButton(
                                          onPressed: () => readAlert(id, true),
                                          style: TextButton.styleFrom(
                                            // minimumSize: const Size.fromHeight(50),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                              SizedBox(width: 10.w),
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
      ),
    );
  }

  void readAlert(id, [bool canClose = false]) {
    isAlertLoading.value = true;
    authProvider.readAlert(id).then((value) {
      isAlertLoading.value = false;
      if ((Get.isDialogOpen ?? false) && canClose) {
        Get.close(1);
      }
    });
  }

  void checkUpdate() {
    authProvider.checkUpdate().then((value) {
      if (value.statusCode == 200) {
        print(value.body);
        final isAndroid = (defaultTargetPlatform == TargetPlatform.android);

        if ((isAndroid
                ? value.body['data']['version']
                : value.body['data']['apple_version']) ==
            null) {
          return;
        }
        newAppVersion.value = (isAndroid
            ? value.body['data']['version']
            : value.body['data']['apple_version']) as String;
        newAppDesc.value = ((isAndroid
                ? value.body['data']['desc']
                : value.body['data']['apple_desc']) ??
            '') as String;
        mustUpdate.value = (isAndroid
            ? value.body['data']['must_update']
            : value.body['data']['apple_must_update']) as bool;
        appleAppId.value = (value.body['data']['apple_app_id'] ?? '') as String;

        isThereNewUpdate.value = checkIsThereNewUpdate(newAppVersion.value);
        if (isThereNewUpdate.value) {
          _showUpdateDiaolog();
        }
      }
    });
  }

  bool checkIsThereNewUpdate(version) {
    return appVersion.compareTo(version) != 0;
  }

  void _showUpdateDiaolog() {
    Get.dialog(
      barrierDismissible: !mustUpdate.value,
      WillPopScope(
        onWillPop: () async {
          return !mustUpdate.value;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 10.h),
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
                          'new_update'.tr,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          newAppDesc.value,
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
                            Expanded(
                              child: Container(
                                // margin: EdgeInsets.only(
                                //     left: 10.w, right: 10.w, bottom: 10.h),
                                child: TextButton(
                                  onPressed: () {
                                    OpenStore.instance.open(
                                      appStoreId: appleAppId
                                          .value, // AppStore id of your app for iOS
                                      androidAppBundleId:
                                          'com.fundbucks.app', // Android app bundle package name
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    // minimumSize: const Size.fromHeight(50),
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
                                      'update_version'.tr,
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
                            !mustUpdate.value
                                ? Expanded(
                                    child: Container(
                                      // margin: EdgeInsets.only(
                                      //     left: 10.w,
                                      //     right: 10.w,
                                      //     bottom: 10.h),
                                      child: TextButton(
                                        onPressed: () {
                                          // Get.clo(1);
                                          if (Get.isDialogOpen ?? false) {
                                            Get.back(closeOverlays: true);
                                          }
                                        },
                                        style: TextButton.styleFrom(
                                          // minimumSize:
                                          //     const Size.fromHeight(50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          // primary: mainColor,
                                          backgroundColor: Colors.grey[300],
                                        ),
                                        child: Center(
                                          child: Text(
                                            'maybe_later'.tr,
                                            style: TextStyle(
                                              //fontFamily: FontFamily.inter,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: ThemeController
                                                      .to.getIsDarkMode
                                                  ? mainColorDarkTheme
                                                  : mainColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
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

  void websocket() {
    LaravelEcho.init(token: presistentData.getAuthToken()!);
  }

  void getUserApi() {
    setIsLoading(true);
    final authToken = presistentData.getAuthToken();
    authProvider.getUser().then((value) {
      // Handle if the token is expired
      setIsLoading(false);
      if (value.statusCode == 200) {
        // final baseSuccessModel = BaseSuccessModel.fromJson(value.body);
        // print(baseSuccessModel);
        try {
          final User? user = User.fromJson(value.body);
          if (user != null) {
            log("User Api: ${user}");
            setUser(user);
            getIsThereNewNotification();
            websocket();
            listenUserUpdateChannel();
          }
          setIsError(false);
        } catch (e) {
          setIsError(true);
          return;
        }

        // Get.showSnackbar(GetSnackBar(
        //   title: 'success'.tr,
        //   message: 'success'.tr,
        //   duration: const Duration(seconds: 2),
        // ));
      } else if (value.statusCode == 401) {
        setIsError(true);
        // final baseErrorModel = BaseErrorModel.fromJson(value.body);
        // print(baseErrorModel);
        presistentData.writeAuthToken('');
        Get.showSnackbar(GetSnackBar(
          title: 'fail'.tr,
          message: 'fail'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
          mainButton: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: ElevatedButton.icon(
              onPressed: getUserApi,
              icon: Icon(Icons.refresh_outlined),
              label: Text('reload'.tr),
            ),
          ),
        ));
        Get.offAndToNamed('/login');
      } else {
        setIsError(true);
        Get.showSnackbar(GetSnackBar(
          title: 'fail'.tr,
          message: 'something_happened'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
          mainButton: ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.refresh_outlined),
            label: Text('reload'.tr),
          ),
        ));
      }
    });
  }

  void listenUserUpdateChannel() {
    Channel channelNew =
        LaravelEcho.pusherClient.subscribe('private-user.${getUser()?.id}');
    channel = channelNew;

    channelNew.bind("user.updated", (PusherEvent? event) {
      if (event?.data != null) {
        _handleNewUserUpdate(event!.data);
      }
    });

    channelNew.bind("user.wallet.updated", (PusherEvent? event) {
      if (event?.data != null) {
        _handleNewUserWalletUpdate(event!.data);
      }
    });

    channelNew.bind("chart.updated", (PusherEvent? event) {
      if (event?.data != null) {
        print(event?.data);
        _handleChartUpdate();
        // _handleNewUserUpdate(event!.data);
      }
    });

    channelNew.bind("update.tickets", (PusherEvent? event) {
      if (event?.data != null) {
        print(event?.data);
        _handleUpdateTickets();
        // _handleNewUserUpdate(event!.data);
      }
    });

    channelNew.bind("close.ticket", (PusherEvent? event) {
      if (event?.data != null) {
        print(event?.data);
        _handleCloseTicket();
        // _handleNewUserUpdate(event!.data);
      }
    });

    channelNew.bind("update.operations", (PusherEvent? event) {
      if (event?.data != null) {
        print(event?.data);
        _handleUpdateOperations();
        // _handleNewUserUpdate(event!.data);
      }
    });

    channelNew.bind("update.reports", (PusherEvent? event) {
      if (event?.data != null) {
        print(event?.data);
        _handleUpdateReports();
        // _handleNewUserUpdate(event!.data);
      }
    });

    channelNew.bind("send.alert", (PusherEvent? event) {
      if (event?.data != null) {
        print(event?.data);
        _handleSendAlert(event?.data);
        // _handleNewUserUpdate(event!.data);
      }
    });
  }

  Channel getChannel() => channel;

  void _handleSendAlert(data) {
    final json = jsonDecode(data);
    final alert = Alert.fromJson(json);
    showAlertDialog(alert.id, alert.title, alert.description);
  }

  void _handleUpdateReports() {
    final reportsController = Get.find<ReportController>();
    if (reportsController.initialized) {
      reportsController.getReports();
    }
  }

  void _handleUpdateOperations() {
    final operationController = Get.find<OperationController>();
    if (operationController.initialized) {
      operationController.getOperations();
    }
  }

  void _handleUpdateTickets() {
    final contactController = Get.find<ContactController>();
    if (contactController.initialized) {
      contactController.getOpenTicket();
    }
  }

  void _handleCloseTicket() {
    final contactController = Get.find<ContactController>();
    if (contactController.initialized) {
      contactController.getAllTickets();
    }
  }

  void _handleChartUpdate() {
    final accountController = Get.find<AccountController>();
    if (accountController.initialized) {
      accountController.getHomePageData(
        accountController.getChoice().toString(),
      );
    }
  }

  void _handleNewUserUpdate(data) {
    final json = jsonDecode(data);

    final user = User.fromJson(json['user']);

    setUser(user);
    if (getUser()?.isBanned == 1) {
      presistentData.writeAuthToken('');
      Get.showSnackbar(GetSnackBar(
        title: 'banned'.tr,
        message: 'banned_details'.tr,
        duration: const Duration(seconds: defaultSnackbarDuration),
      ));
      Get.offNamedUntil('/login', ModalRoute.withName('newlogin'));
    }
  }

  void _handleNewUserWalletUpdate(data) {
    final json = jsonDecode(data);

    var newJson = jsonEncode({
      'chart': null,
      'wallet': json['chart'],
    });

    final chart = Chart.fromJson(jsonDecode(newJson));
    print(chart);
    final accountController = Get.find<AccountController>();
    accountController.setChartWallet(chart.wallet ?? []);
  }

  void getIsThereNewNotification() {
    authProvider.isThereNotification().then((value) {
      if (value.statusCode == 200) {
        print(value.body['data'].runtimeType);
        setIsThereNotification(value.body['data'] as bool);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    try {
      LaravelEcho.instance.disconnect();
    } catch (e) {}
  }

  void setIndex(value) {
    index.value = value;
    if (value == 3) {
      final contactController = Get.find<ContactController>();
      if (contactController.checkIfTheresANewMessage()) {
        contactController.setIndex(1);
        // TODO: Open the ticket page if the message on one ticket
        if (contactController.checkIfMultiTicketMessages()) return;
        final index = contactController.getNewTicketHaveMessage();
        if (index == -1) return;

        final ticket = contactController.getTicket(index);
        if (ticket == null) return;

        Get.toNamed('/ticket', arguments: [
          index, // 0
          'ticket'.trParams({'id': ticket.ticket!}), // 1
          ticket.name, // 2
          ticket.subject, // 3
          intl.DateFormat('yyyy-MM-dd h:m a')
              .format(ticket.createdAt ?? tz.TZDateTime.now(kuwaitTimezoneLocation))
              .toString(), // 4
          false, // 5
          ticket.status, // 6
        ]);
      }
    }
  }
}
