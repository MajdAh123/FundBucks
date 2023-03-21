import 'package:app/app/modules/gateway_detail/providers/gateway_provider.dart';
import 'package:get/get.dart';

import '../controllers/gateway_detail_controller.dart';

class GatewayDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GatewayProvider>(GatewayProvider());
    Get.lazyPut<GatewayDetailController>(
      () => GatewayDetailController(
        gatewayProvider: Get.find<GatewayProvider>(),
      ),
    );
  }
}
