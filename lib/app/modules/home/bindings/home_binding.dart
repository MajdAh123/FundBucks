import 'package:app/app/modules/home/providers/account_page_provider.dart';
import 'package:app/app/modules/home/providers/auth_provider.dart';
import 'package:app/app/modules/home/providers/contact_provider.dart';
import 'package:app/app/modules/home/providers/operation_page_provider.dart';
import 'package:app/app/modules/home/providers/report_provider.dart';
import 'package:get/get.dart';

import 'package:app/app/modules/home/controllers/account_controller.dart';
import 'package:app/app/modules/home/controllers/contact_controller.dart';
import 'package:app/app/modules/home/controllers/operation_controller.dart';
import 'package:app/app/modules/home/controllers/profile_controller.dart';
import 'package:app/app/modules/home/controllers/report_controller.dart';

import '../../edit_profile/controllers/edit_profile_controller.dart';
import '../../edit_profile/providers/user_provider.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ContactProvider>(ContactProvider());
    Get.lazyPut<ContactController>(
      () => ContactController(
        contactProvider: Get.find<ContactProvider>(),
      ),
      fenix: true,
    );

    Get.put<OperationPageProvider>(OperationPageProvider());
    Get.lazyPut<OperationController>(
      () => OperationController(
          operationPageProvider: Get.find<OperationPageProvider>()),
      fenix: true,
    );

    Get.put<ReportProvider>(ReportProvider());
    Get.lazyPut<ReportController>(
      () => ReportController(
        reportProvider: Get.find(),
      ),
      fenix: true,
    );

    Get.put<AccountPageProvider>(AccountPageProvider());
    Get.lazyPut<AccountController>(
      () => AccountController(
          accountPageProvider: Get.find<AccountPageProvider>()),
      fenix: true,
    );

    Get.lazyPut<AuthProvider>(
      () => AuthProvider(),
    );

    Get.lazyPut<ProfileController>(
      () => ProfileController(
        authProvider: Get.find<AuthProvider>(),
      ),
      fenix: true,
    );

    Get.lazyPut<HomeController>(
      () => HomeController(
        authProvider: Get.find<AuthProvider>(),
      ),
      fenix: true,
    );
  }
}
