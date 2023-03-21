import 'package:app/app/data/base_get_connect.dart';
import 'package:app/app/data/data.dart';
import 'package:app/app/utils/endpoints.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class AccountPageProvider extends BaseGetConnect {
  @override
  void onInit() {
    super.onInit();
    final presistentData = PresistentData();
    httpClient.timeout = const Duration(seconds: 20);
    httpClient.addAuthenticator((Request request) {
      String authToken = presistentData.getAuthToken() ?? '';
      var headers = {'Authorization': "Bearer $authToken"};
      request.headers.addAll(headers);
      return request;
    });
  }

  Future<Response> getStocks() => get(EndPoints.stocks);
  Future<Response> getHomePageData(type) =>
      get(EndPoints.homePageData + '?type=$type');
}
