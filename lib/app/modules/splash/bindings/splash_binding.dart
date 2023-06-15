import 'package:app/app/modules/splash/providers/splash_provider.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashProvider>(() => SplashProvider());
    // Get.put(PresistentData());
    Get.put(SplashController(
      splashProvider: Get.find<SplashProvider>(),
    ));
  }
}
