import 'package:app/app/data/base_get_connect.dart';
import 'package:app/app/data/data.dart';
import 'package:app/app/utils/endpoints.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class UserProvider extends BaseGetConnect {
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

  Future<Response> updateUser(body) => post(EndPoints.updateUser, body);
  Future<Response> resetAvatar() => get(EndPoints.resetAvatar);
  Future<Response> deleteAccount(body) => post(EndPoints.deleteAccount, body);
}
