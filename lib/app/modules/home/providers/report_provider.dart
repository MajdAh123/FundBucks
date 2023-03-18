import 'package:app/app/data/base_get_connect.dart';
import 'package:app/app/data/data.dart';
import 'package:app/app/utils/endpoints.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class ReportProvider extends BaseGetConnect {
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

  Future<Response> getReport(body) => post(EndPoints.report, body);
  Future<Response> getReports() => get(EndPoints.reports);
}
