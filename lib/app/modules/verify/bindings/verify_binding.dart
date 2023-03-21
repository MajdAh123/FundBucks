import 'package:app/app/modules/verify/providers/verify_provider.dart';
import 'package:get/get.dart';

import '../controllers/verify_controller.dart';

class VerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VerifyProvider());
    Get.lazyPut<VerifyController>(
      () => VerifyController(
        verifyProvider: Get.find<VerifyProvider>(),
      ),
    );
  }
}
