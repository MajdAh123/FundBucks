import 'package:app/app/data/base_get_connect.dart';
import 'package:app/app/utils/utils.dart';
import 'package:get/get.dart';

class GatewayProvider extends BaseGetConnect {
  @override
  void onInit() {
    super.onInit();
  }

  Future<Response> getWireDetails(id) =>
      get(EndPoints.gatewayDetails + '/' + id);
}
