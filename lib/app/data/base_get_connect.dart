import 'package:app/app/utils/endpoints.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class BaseGetConnect extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = EndPoints.getEndApiPoint();
    httpClient.defaultContentType = 'application/json';
    httpClient.addRequestModifier((Request request) {
      request.headers['Accept'] = 'application/json';
      // request.headers['Content-Type'] = 'application/json';
      return request;
    });
    httpClient.timeout = Duration(seconds: 30);
  }
}
