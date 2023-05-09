import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class AboutUsController extends GetxController {
  final homeController = Get.find<HomeController>();

  String getAppleId() => homeController.appleAppId.value;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
