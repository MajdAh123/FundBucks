import 'package:app/app/data/base_get_connect.dart';
import 'package:app/app/data/data.dart';
import 'package:app/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class OperationPageProvider extends BaseGetConnect {
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

  Future<Response> getGateways() => get(EndPoints.gateways);
  Future<Response> sendDeposit(body) => post(EndPoints.sendDeposit, body);
  Future<Response> sendWithdraw(body) => post(EndPoints.sendWithdraw, body);
  Future<Response> getPortfolio() => get(EndPoints.createAccountPortfolio);

  Future<Response> getDepostis() => get(EndPoints.deposits);
  Future<Response> getWithdraws() => get(EndPoints.withdraws);
}
