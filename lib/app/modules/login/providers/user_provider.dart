import 'package:app/app/data/base_get_connect.dart';
import 'package:app/app/utils/utils.dart';
import 'package:get/get.dart';

class UserProvider extends BaseGetConnect {
  @override
  void onInit() {
    super.onInit();
  }

  Future<Response> checkUpdate() => get(EndPoints.checkUpdate);
  Future<Response> login(body) => post(EndPoints.login, body);
}
