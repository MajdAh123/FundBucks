import 'package:app/app/data/base_get_connect.dart';
import 'package:app/app/utils/endpoints.dart';
import 'package:get/get.dart';

class VerifyProvider extends BaseGetConnect {
  @override
  void onInit() {
    super.onInit();
  }

  Future<Response> verifyCode(body) => post(EndPoints.verify, body);
  Future<Response> sendVerifyCode(body) => post(EndPoints.sendVerify, body);
}
