import 'package:app/app/modules/login/providers/user_provider.dart';
import 'package:app/app/modules/setting/providers/setting_provider.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProvider>(() => UserProvider());
    Get.put<LoginController>(LoginController(userProvider: Get.find()),
        permanent: true);
  }
}
