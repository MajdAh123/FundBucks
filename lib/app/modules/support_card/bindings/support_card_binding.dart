import 'package:app/app/modules/support_card/providers/support_card_provider.dart';
import 'package:get/get.dart';

import '../controllers/support_card_controller.dart';

class SupportCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SupportCardProvider>(SupportCardProvider());
    Get.lazyPut<SupportCardController>(
      () => SupportCardController(
        supportCardProvider: Get.find<SupportCardProvider>(),
      ),
    );
  }
}
