import 'package:app/app/modules/ticket/providers/ticket_provider.dart';
import 'package:get/get.dart';

import '../controllers/ticket_controller.dart';

class TicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TicketProvider>(TicketProvider());
    Get.lazyPut<TicketController>(
      () => TicketController(
        ticketProvider: Get.find<TicketProvider>(),
      ),
    );
  }
}
