import 'dart:convert';
import 'dart:developer';

import 'package:app/app/data/data.dart';
import 'package:app/app/data/models/models.dart';
import 'package:app/app/data/models/notification.dart' as NN;
import 'package:app/app/modules/home/controllers/account_controller.dart';
// import 'package:app/app/modules/home/controllers/account_controller.dart';
// import 'package:app/app/modules/home/controllers/contact_controller.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/home/controllers/operation_controller.dart';
import 'package:app/app/modules/home/controllers/report_controller.dart';
import 'package:app/app/modules/home/providers/auth_provider.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/routes/app_pages.dart';
// import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/utils/colors.dart';
import 'package:app/app/utils/constant.dart';
// import 'package:app/app/utils/endpoints.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:http/http.dart' as http;

import 'edit_profile/providers/user_provider.dart';
import 'home/controllers/contact_controller.dart';

class GlobalNotificationController extends GetxController {
  var fcmToken = ''.obs;
  late final FirebaseMessaging _messaging;
  final presistentData = PresistentData();

  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String getFcmToken() => fcmToken.value;
  void setFcmToken(String fcmToken) => this.fcmToken.value = fcmToken;

  void registerNotification() async {
    _messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          final presistentData = PresistentData();
          if (presistentData.getAuthToken() != null) {
            if (presistentData.getAuthToken()!.isNotEmpty) {
              final homeController = Get.find<HomeController>();
              homeController.setIsThereNotification(true);
            }
          }

          AndroidNotification? android = message.notification?.android;

          PushNotification notification = PushNotification(
            title: message.notification?.title,
            body: message.notification?.body,
          );
          log("New notification: " + (notification.title ?? ''));
          showSimpleNotification(
            Text(
              notification.title!,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: ThemeController.to.getIsDarkMode
                    ? containerColorLightTheme
                    : Colors.black,
              ),
            ),
            subtitle: Text(
              notification.body!,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: ThemeController.to.getIsDarkMode
                    ? unselectedBottomBarItemColorDarkTheme
                    : Colors.black,
              ),
            ),
            background: ThemeController.to.getIsDarkMode
                ? containerColorDarkTheme
                : containerColorLightTheme,
            duration: Duration(seconds: defaultSnackbarDuration),
            autoDismiss: true,
            slideDismissDirection: DismissDirection.up,
          );

          if (notification.title != null &&
              notification.body != null &&
              android != null) {
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    channelDescription: channel.description,
                    color: mainColor,
                    playSound: true,
                    icon: '@drawable/ic_stat_logo_transparent',
                  ),
                ));
          }
        },
      );

      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        log("Clicked the notification");

        if (notification != null && android != null) {
          print("=========================");
          // print(message.messageId);
          // final notificationControll = Get.put(NotificationController(
          //     notificationProvider: NotificationProvider()));
          // await notificationControll.getNoti().then((value) {
          //   print(value.length);
          // });
          List<NN.Notification> fiter = [];
          await getNotification().then((value) {
            fiter = value
                .where((element) =>
                    element.title == notification.title &&
                    element.description == notification.body)
                .toList();
          });

          // print(notificationControll.notificationsToUser[0].action);
          print(fiter.last.action);
          print("=========================");
          if (fiter.last.action == null) {
            Get.toNamed('/notification');
          } else {
            changePageUsingActions(fiter.last.action!);
          }
          //
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // final homeController = Get.put(HomeController(authProvider: AuthProvider()));
  Future<List<NN.Notification>> getNotification() async {
    String? authToken = presistentData.getAuthToken();
    var headers = {'Authorization': "Bearer $authToken"};

    try {
      var uri = Uri.https("app.fundbucks.com", "/api/v1/notifications");

      var response = await http.get(uri, headers: headers);

      print("++++++++++++++++++++++++++");
      print(response.body);
      var jsonResponse = json.decode(response.body);
      List<dynamic> jsonList = jsonResponse['data'];
      // List<Map<String, dynamic>> jsonList = json.decode(response.body[1]);
      List<NN.Notification> notifications = jsonList
          .map((json) => NN.Notification.fromJson(json as Map<String, dynamic>))
          .toList();

      // List<NN.Notification> as = [];
      // List<NN.Notification> notifications =
      //     jsonList.map((json) => NN.Notification.fromJson(json)).toList();

      print("++++++++++++++++++++++++++");
      return notifications;
    } catch (e) {
      print("eeeeeeeeeeeeeee");
      print(e);
      print("eeeeeeeeeeeeeee");
      return [];
    }
  }

  void changePageUsingActions(String action) {
    if (presistentData.getAuthToken() != null) {
      if (presistentData.getAuthToken()!.isNotEmpty) {
        // final homeController = Get.find<HomeController>();
        final homeController =
            Get.put(HomeController(authProvider: AuthProvider()));
        // homeController.setIsThereNotification(true);
        switch (action) {
          case 'p0':
            homeController.setIndex(0);
            // Get.close(0);
            break;
          case 'p0-e':
            homeController.setIndex(0);
            final accountController = Get.find<AccountController>();
            // Get.close(0);
            accountController.scrollToItem();
            break;
          case 'p1':
            homeController.setIndex(1);
            // Get.close(0);
            break;
          case 'p1-e':
            homeController.setIndex(1);
            final reportController = Get.find<ReportController>();
            // Get.close(0);
            reportController.scrollToItem();
            break;
          case 'p2-0':
            homeController.setIndex(2);
            final operationController = Get.find<OperationController>();
            operationController.setIndex(1);
            // Get.close(0);
            break;
          case 'p2-0-e':
            homeController.setIndex(2);
            final operationController = Get.find<OperationController>();
            operationController.setIndex(1);
            // Get.close(0);
            operationController.scrollToItem();
            break;
          case 'p2-1':
            homeController.setIndex(2);
            final operationController = Get.find<OperationController>();
            operationController.setIndex(0);
            // Get.close(0);
            break;
          case 'p2-1-e':
            homeController.setIndex(2);
            final operationController = Get.find<OperationController>();
            operationController.setIndex(0);
            // Get.close(0);
            operationController.scrollToItem();
            break;
          case 'p3-0':
            homeController.setIndex(3);
            final contactController = Get.find<ContactController>();
            contactController.selectIndex(0);
            // Get.close(0);
            break;
          case 'p3-1':
            homeController.setIndex(3);
            final contactController = Get.find<ContactController>();
            contactController.selectIndex(1);
            // Get.close(0);
            break;
          case 'p3-2':
            homeController.setIndex(3);
            final contactController = Get.find<ContactController>();
            contactController.selectIndex(2);
            // Get.close(0);
            break;
          case 'p4':
            homeController.setIndex(4);

            // Get.close(0);
            break;
          case 'p5':
            homeController.setIndex(4);
            // Get.close(0);
            Get.toNamed(Routes.SUPPORT_CARD);
            break;
          default:
            // print("asd");
            Get.toNamed('/notification');
            break;
        }
        homeController.update();
      }
    }
  }

  getToken() async {
    // await FirebaseMessaging.instance.getToken().then((value) async {
    //   print('FCM Token: $value');
    //   setFcmToken(value ?? '');
    //   presistentData.writeFcmToken(value!);
    //   final userProvider = Get.put(UserProvider());

    //   userProvider.update_tokenUser({"fcm_token": value}).then((value) {
    //     if (value.statusCode == 200) {
    //       print("dooooooooooooooooooooon");
    //     } else {
    //       print("oppps");
    //     }
    //   });
    // });
  }

  checkForInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      final presistentData = PresistentData();
      if (presistentData.getAuthToken() != null) {
        if (presistentData.getAuthToken()!.isNotEmpty) {
          final homeController = Get.find<HomeController>();
          homeController.setIsThereNotification(true);
        }
      }
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );
      showSimpleNotification(
        Text(
          notification.title ?? '',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ThemeController.to.getIsDarkMode
                ? containerColorLightTheme
                : Colors.black,
          ),
        ),
        subtitle: Text(
          notification.body ?? '',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: ThemeController.to.getIsDarkMode
                ? unselectedBottomBarItemColorDarkTheme
                : Colors.black,
          ),
        ),
        background: ThemeController.to.getIsDarkMode
            ? containerColorDarkTheme
            : containerColorLightTheme,
        duration: Duration(seconds: 4),
      );
    }
  }

  @override
  void onInit() {
    getNotification();
    defineNotificationVars().then((value) {
      registerNotification();
      checkForInitialMessage();
    });

    // if (presistentData.getFcmToken() == null) {
    //   getToken();
    // } else if (presistentData.getFcmToken()!.isEmpty) {
    //   getToken();
    // }
    getToken();

    super.onInit();
  }

  Future<void> defineNotificationVars() async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@drawable/ic_stat_logo_transparent');
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
