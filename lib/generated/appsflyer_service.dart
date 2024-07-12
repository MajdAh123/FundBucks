import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';

class AppsFlyerService {
  final AppsFlyerOptions options = AppsFlyerOptions(
    afDevKey: 'TCVM5ETERvE937YUfeCG4K',
    appId: Platform.isAndroid ? 'com.fundbucks.app' : "id6449863528",
    showDebug: true,
  );

  late AppsflyerSdk _appsflyerSdk;

  // AppsFlyerService() : ;

  void initSdk() {
    try {
      print("*****************************");

      _appsflyerSdk = AppsflyerSdk(options);
      _appsflyerSdk.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true,
      );
      print("*****************************");
    } catch (e) {
      print("==================");
      print(e);
      print("==================");
    }
  }
}
