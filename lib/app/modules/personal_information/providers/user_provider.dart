import 'package:app/app/data/base_get_connect.dart';
import 'package:app/app/utils/utils.dart';
import 'package:get/get.dart';

class UserPersonalProvider extends BaseGetConnect {
  @override
  void onInit() {
    super.onInit();
  }

  // Here we will send the user data to create a new user model in API
  // Future<User> createUser(User user) {

  Future<Response> postUser(body) => post(EndPoints.create, body);
}
