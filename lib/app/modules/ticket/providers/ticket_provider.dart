import 'package:app/app/data/base_get_connect.dart';
import 'package:app/app/data/data.dart';
import 'package:app/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class TicketProvider extends BaseGetConnect {
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

  Future<Response> getTicket(ticketId) =>
      get(EndPoints.ticketDetail + '/' + ticketId.toString());
  Future<Response> createMessage(body) => post(EndPoints.createMessage, body);
  Future<Response> closeTicket(ticketId) =>
      get(EndPoints.closeTicket + '/' + ticketId.toString());
}
