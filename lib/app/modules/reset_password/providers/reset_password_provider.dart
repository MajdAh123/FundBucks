import 'package:app/app/data/base_get_connect.dart';
import 'package:app/app/utils/endpoints.dart';
import 'package:get/get.dart';

class ResetPasswordProvider extends BaseGetConnect {
  @override
  void onInit() {
    super.onInit();
  }

  Future<Response> resetPassword(body) => post(EndPoints.resetPassword, body);
}
