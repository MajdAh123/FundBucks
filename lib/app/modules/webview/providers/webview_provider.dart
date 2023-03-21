import 'package:app/app/data/base_get_connect.dart';
import 'package:app/app/utils/endpoints.dart';
import 'package:get/get.dart';

class WebviewProvider extends BaseGetConnect {
  @override
  void onInit() {
    super.onInit();
  }

  Future<Response> getWebViewUrlType(type) =>
      get(EndPoints.webviewUrl + type.toString());
}
