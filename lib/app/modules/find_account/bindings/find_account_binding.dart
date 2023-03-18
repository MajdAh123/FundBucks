import 'package:app/app/modules/find_account/providers/find_account_provider.dart';
import 'package:get/get.dart';

import '../controllers/find_account_controller.dart';

class FindAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FindAccountProvider());
    Get.lazyPut<FindAccountController>(
      () => FindAccountController(
        findAccountProvider: Get.find<FindAccountProvider>(),
      ),
    );
  }
}
