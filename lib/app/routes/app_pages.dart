import 'package:get/get.dart';

import '../middlewares/auth_middleware.dart';
import '../modules/about_us/bindings/about_us_binding.dart';
import '../modules/about_us/views/about_us_view.dart';
import '../modules/create_account/bindings/create_account_binding.dart';
import '../modules/create_account/views/create_account_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/find_account/bindings/find_account_binding.dart';
import '../modules/find_account/views/find_account_view.dart';
import '../modules/gateway_detail/bindings/gateway_detail_binding.dart';
import '../modules/gateway_detail/views/gateway_detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/pdfviewer/bindings/pdfviewer_binding.dart';
import '../modules/pdfviewer/views/pdfviewer_view.dart';
import '../modules/personal_information/bindings/personal_information_binding.dart';
import '../modules/personal_information/views/personal_information_view.dart';
import '../modules/photo/bindings/photo_binding.dart';
import '../modules/photo/views/photo_view.dart';
import '../modules/portfolio_information/bindings/portfolio_information_binding.dart';
import '../modules/portfolio_information/views/portfolio_information_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/support_card/bindings/support_card_binding.dart';
import '../modules/support_card/views/support_card_view.dart';
import '../modules/ticket/bindings/ticket_binding.dart';
import '../modules/ticket/views/ticket_view.dart';
import '../modules/verify/bindings/verify_binding.dart';
import '../modules/verify/views/verify_view.dart';
import '../modules/webview/bindings/webview_binding.dart';
import '../modules/webview/views/webview_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      middlewares: [
        AuhtMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_ACCOUNT,
      page: () => CreateAccountView(),
      binding: CreateAccountBinding(),
    ),
    GetPage(
      name: _Paths.PORTFOLIO_INFORMATION,
      page: () => PortfolioInformationView(),
      binding: PortfolioInformationBinding(),
    ),
    GetPage(
      name: _Paths.PERSONAL_INFORMATION,
      page: () => PersonalInformationView(),
      binding: PersonalInformationBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
      middlewares: [
        AuhtMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
      middlewares: [
        AuhtMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
      middlewares: [
        AuhtMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.TICKET,
      page: () => TicketView(),
      binding: TicketBinding(),
      middlewares: [
        AuhtMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.GATEWAY_DETAIL,
      page: () => GatewayDetailView(),
      binding: GatewayDetailBinding(),
      middlewares: [
        AuhtMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.VERIFY,
      page: () => VerifyView(),
      binding: VerifyBinding(),
      // middlewares: [
      //   AuhtMiddleware(),
      // ],
    ),
    GetPage(
      name: _Paths.PDFVIEWER,
      page: () => PdfviewerView(),
      binding: PdfviewerBinding(),
    ),
    GetPage(
      name: _Paths.WEBVIEW,
      page: () => WebviewView(),
      binding: WebviewBinding(),
    ),
    GetPage(
      name: _Paths.SUPPORT_CARD,
      page: () => SupportCardView(),
      binding: SupportCardBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FIND_ACCOUNT,
      page: () => FindAccountView(),
      binding: FindAccountBinding(),
    ),
    GetPage(
      name: _Paths.PHOTO,
      page: () => PhotoView(),
      binding: PhotoBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_US,
      page: () => const AboutUsView(),
      binding: AboutUsBinding(),
    ),
  ];
}
