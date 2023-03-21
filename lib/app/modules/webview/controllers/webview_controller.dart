import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app/app/modules/webview/providers/webview_provider.dart';
import 'package:webview_flutter/webview_flutter.dart' as webview;

class WebviewController extends GetxController {
  final WebviewProvider webviewProvider;
  WebviewController({
    required this.webviewProvider,
  });

  webview.WebViewController webviewController = webview.WebViewController();

  var pageTitle = ''.obs;
  var pageWebUrl = ''.obs;
  var id = 0.obs;

  var isLoading = false.obs;

  void setPageTitle(String pageTitle) => this.pageTitle.value = pageTitle;
  String getPageTitle() => pageTitle.value;

  void setId(int id) => this.id.value = id;
  int getId() => id.value;

  void setIsLoading(bool isLoading) => this.isLoading.value = isLoading;
  bool getIsLoading() => isLoading.value;

  void setPageWebUrl(String pageWebUrl) => this.pageWebUrl.value = pageWebUrl;
  String getPageWebUrl() => pageWebUrl.value;

  bool checkIfPageIsLoading() => getPageWebUrl().isEmpty;

  @override
  void onInit() {
    getPageParameter();
    initWebView();

    super.onInit();
  }

  void getPageParameter() {
    var data = Get.arguments;
    setPageTitle(data[0]);
    setId(data[1]);
  }

  void initWebView() {
    setIsLoading(true);
    webviewProvider.getWebViewUrlType(getId()).then((value) {
      print(value.body);
      if (value.statusCode == 200) {
        setPageWebUrl(value.body['data']);
        webviewController = webview.WebViewController()
          ..setJavaScriptMode(webview.JavaScriptMode.unrestricted)
          ..setBackgroundColor(Colors.white)
          ..setNavigationDelegate(
            webview.NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {},
              onWebResourceError: (webview.WebResourceError error) {},
              onNavigationRequest: (webview.NavigationRequest request) {
                // if (request.url.startsWith('https://www.youtube.com/')) {
                //   return webview.NavigationDecision.prevent;
                // }
                return webview.NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(getPageWebUrl()));
        setIsLoading(false);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
