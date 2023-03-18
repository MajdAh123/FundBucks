import 'package:app/app/modules/personal_information/providers/user_provider.dart';
import 'package:get/get.dart';

import '../controllers/personal_information_controller.dart';

class PersonalInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserPersonalProvider());
    Get.put<PersonalInformationController>(PersonalInformationController(
      userProvider: Get.find(),
    ));
  }
}
