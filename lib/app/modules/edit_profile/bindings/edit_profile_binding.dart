import 'package:app/app/modules/edit_profile/providers/user_provider.dart';
import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserProvider>(UserProvider());
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(
        userProvider: Get.find<UserProvider>(),
      ),
    );
  }
}
