import 'package:app/app/modules/setting/providers/setting_provider.dart';
import 'package:get/get.dart';

import '../controllers/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingProvider());
    Get.lazyPut<SettingController>(
      () => SettingController(
        settingProvider: Get.find<SettingProvider>(),
      ),
    );
  }
}
