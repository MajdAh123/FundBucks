import 'package:app/app/modules/portfolio_information/providers/portfolio_provider.dart';
import 'package:get/get.dart';

import '../controllers/portfolio_information_controller.dart';

class PortfolioInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PortfolioProvider());
    Get.put<PortfolioInformationController>(
      PortfolioInformationController(portfolioProvider: Get.find()),
    );
  }
}
