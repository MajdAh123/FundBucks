import 'dart:async';

import 'package:app/app/data/models/models.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/notification/providers/notification_provider.dart';
import 'package:app/app/utils/utils.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final loading = true.obs;
  final isError = false.obs;

  RxList<Notification> notifications = <Notification>[].obs;

  final NotificationProvider notificationProvider;

  NotificationController({required this.notificationProvider});

  void setLoading(bool value) => loading.value = value;
  getLoading() => loading.value;

  void setIsError(bool value) => isError.value = value;
  getIsError() => isError.value;

  List<Notification> getNotifications() => notifications;
  void setNotifications(value) => notifications.value = value;

  final homeController = Get.find<HomeController>();

  @override
  void onInit() {
    getAllNotifications();
    super.onInit();
  }

  void getAllNotifications() {
    setLoading(true);
    getIsThereNewNotification();
    notificationProvider.getNotifications().then((value) {
      setLoading(false);
      if (value.statusCode == 200) {
        // final baseSuccessModel = BaseSuccessModel.fromJson(value.body);
        // print(value.body);

        final notifications = (value.body['data'] as List)
            .map<Notification>((e) => Notification.fromJson(e))
            .toList();
        setNotifications(notifications);
      } else {
        setIsError(true);
        Get.showSnackbar(GetSnackBar(
          title: 'fail'.tr,
          message: 'something_happened'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
        ));
      }
    });
  }

  void readNotification(id) {
    setLoading(true);
    notificationProvider.readNotification(id).then((value) {
      setLoading(false);
      if (value.statusCode == 200) {
        if (getNotifications().length == 1) {
          homeController.setIsThereNotification(false);
        }
        Get.showSnackbar(GetSnackBar(
          title: 'success'.tr,
          message: 'notification_read'.tr,
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
    getAllNotifications();
  }

  void deleteNotification(id) {
    setLoading(true);
    notificationProvider.deleteNotification(id).then((value) {
      setLoading(false);
      if (value.statusCode == 200) {
        if (getNotifications().length == 1) {
          homeController.setIsThereNotification(false);
        }
        // delete_notification
        Get.showSnackbar(GetSnackBar(
          title: 'success'.tr,
          message: 'delete_notification'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
        ));
        getAllNotifications();
      }
    });
  }

  void readAllNotifications() {
    setLoading(true);
    notificationProvider.readAllNotifications().then((value) {
      setLoading(false);
      if (value.statusCode == 200) {
        final homeController = Get.find<HomeController>();
        homeController.setIsThereNotification(false);
        Get.showSnackbar(GetSnackBar(
          title: 'success'.tr,
          message: 'all_notifications_read'.tr,
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
    getAllNotifications();
  }

  void getIsThereNewNotification() {
    notificationProvider.isThereNotification().then((value) {
      if (value.statusCode == 200) {
        homeController.setIsThereNotification(value.body['data'] as bool);
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
