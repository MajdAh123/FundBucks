import 'package:app/app/modules/notification/providers/notification_provider.dart';
import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NotificationProvider>(NotificationProvider());
    Get.lazyPut<NotificationController>(
      () => NotificationController(
        notificationProvider: Get.find<NotificationProvider>(),
      ),
    );
  }
}
