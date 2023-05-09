import 'package:app/app/data/base_get_connect.dart';
import 'package:app/app/data/presistent/presistent_data.dart';
import 'package:app/app/utils/endpoints.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class AuthProvider extends BaseGetConnect {
  @override
  void onInit() {
    super.onInit();
    final presistentData = PresistentData();

    httpClient.addAuthenticator((Request request) {
      String authToken = presistentData.getAuthToken() ?? '';
      var headers = {'Authorization': "Bearer $authToken"};
      request.headers.addAll(headers);
      return request;
    });
  }

  Future<Response> checkUpdate() => get(EndPoints.checkUpdate);
  Future<Response> getUser() => get(EndPoints.getUser);
  Future<Response> isThereNotification() => get(EndPoints.isThereNotification);
  Future<Response> setNotification(body) =>
      post(EndPoints.updateNotifications, body);
  Future<Response> getAlerts() => get(EndPoints.alerts);
  Future<Response> readAlert(id) =>
      get(EndPoints.readAlert + '/${id.toString()}');

  Future<Response> changeAccountMode() => get(EndPoints.changeAccountMode);
}
