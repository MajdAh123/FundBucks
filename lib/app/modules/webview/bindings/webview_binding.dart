import 'package:app/app/modules/webview/providers/webview_provider.dart';
import 'package:get/get.dart';

import '../controllers/webview_controller.dart';

class WebviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WebviewProvider>(WebviewProvider());
    Get.lazyPut<WebviewController>(
      () => WebviewController(
        webviewProvider: Get.find<WebviewProvider>(),
      ),
    );
  }
}
