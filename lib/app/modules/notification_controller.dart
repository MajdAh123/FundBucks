import 'dart:developer';

import 'package:app/app/data/data.dart';
import 'package:app/app/data/models/models.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/colors.dart';
import 'package:app/app/utils/constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

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

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        log("Clicked the notification");

        if (notification != null && android != null) {
          Get.toNamed('/notification');
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  getToken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      print('FCM Token: $value');
      setFcmToken(value ?? '');
      presistentData.writeFcmToken(value ?? '');
    });
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
