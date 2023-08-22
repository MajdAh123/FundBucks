import 'package:app/app/data/models/models.dart';
import 'package:app/app/modules/home/controllers/account_controller.dart';
import 'package:app/app/modules/home/controllers/contact_controller.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/home/controllers/operation_controller.dart';
import 'package:app/app/modules/home/controllers/report_controller.dart';
import 'package:app/app/modules/notification/providers/notification_provider.dart';
import 'package:app/app/routes/app_pages.dart';
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

  void readNotification(id, String? title, String? action) {
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
        if (title == null) return;
        changePageUsingTitle(title);
        if (action == null) return;
        changePageUsingActions(action);
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

  void changePageUsingTitle(String title) {
    if (title.contains('رسالة جديدة')) {
      homeController.setIndex(3);
      Get.close(1);
    } else if (title.contains('عملية إيداع جديدة')) {
      homeController.setIndex(2);
      final operationController = Get.find<OperationController>();
      operationController.setIndex(1);
      Get.close(1);
    } else if (title.contains('عملية سحب جديدة')) {
      homeController.setIndex(2);
      final operationController = Get.find<OperationController>();
      operationController.setIndex(0);
      Get.close(1);
    }
  }

  void changePageUsingActions(String action) {
    switch (action) {
      case 'p0':
        homeController.setIndex(0);
        Get.close(0);
        break;
      case 'p0-e':
        homeController.setIndex(0);
        final accountController = Get.find<AccountController>();
        Get.close(0);
        accountController.scrollToItem();
        break;
      case 'p1':
        homeController.setIndex(1);
        Get.close(0);
        break;
      case 'p1-e':
        homeController.setIndex(1);
        final reportController = Get.find<ReportController>();
        Get.close(0);
        reportController.scrollToItem();
        break;
      case 'p2-0':
        homeController.setIndex(2);
        final operationController = Get.find<OperationController>();
        operationController.setIndex(1);
        Get.close(0);
        break;
      case 'p2-0-e':
        homeController.setIndex(2);
        final operationController = Get.find<OperationController>();
        operationController.setIndex(1);
        Get.close(0);
        operationController.scrollToItem();
        break;
      case 'p2-1':
        homeController.setIndex(2);
        final operationController = Get.find<OperationController>();
        operationController.setIndex(0);
        Get.close(0);
        break;
      case 'p2-1-e':
        homeController.setIndex(2);
        final operationController = Get.find<OperationController>();
        operationController.setIndex(0);
        Get.close(0);
        operationController.scrollToItem();
        break;
      case 'p3-0':
        homeController.setIndex(3);
        final contactController = Get.find<ContactController>();
        contactController.selectIndex(0);
        Get.close(0);
        break;
      case 'p3-1':
        homeController.setIndex(3);
        final contactController = Get.find<ContactController>();
        contactController.selectIndex(1);
        Get.close(0);
        break;
      case 'p3-2':
        homeController.setIndex(3);
        final contactController = Get.find<ContactController>();
        contactController.selectIndex(2);
        Get.close(0);
        break;
      case 'p4':
        homeController.setIndex(4);
        Get.close(0);
        break;
      case 'p5':
        // homeController.setIndex(4);
        Get.close(0);
        Get.toNamed(Routes.SUPPORT_CARD);
        break;
    }
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
