import 'package:app/app/modules/photo/providers/photo_provider.dart';
import 'package:get/get.dart';

import '../controllers/photo_controller.dart';

class PhotoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PhotoProvider>(PhotoProvider());
    Get.lazyPut<PhotoController>(
      () => PhotoController(
        photoProvider: Get.find<PhotoProvider>(),
      ),
    );
  }
}
