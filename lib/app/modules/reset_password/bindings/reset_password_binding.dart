import 'package:app/app/modules/reset_password/providers/reset_password_provider.dart';
import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ResetPasswordProvider());
    Get.lazyPut<ResetPasswordController>(
      () => ResetPasswordController(
        resetPasswordProvider: Get.find<ResetPasswordProvider>(),
      ),
    );
  }
}
