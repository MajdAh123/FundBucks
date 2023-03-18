import 'package:app/app/modules/create_account/providers/create_account_provider.dart';
import 'package:get/get.dart';

import '../controllers/create_account_controller.dart';

class CreateAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CreateAccountProvider>(CreateAccountProvider());
    Get.lazyPut<CreateAccountController>(
      () => CreateAccountController(
          createAccountProvider: Get.find<CreateAccountProvider>()),
    );
  }
}
