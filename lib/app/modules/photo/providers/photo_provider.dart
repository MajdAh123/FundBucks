import 'package:app/app/data/base_get_connect.dart';
import 'package:get/get.dart';

class PhotoProvider extends BaseGetConnect {
  @override
  void onInit() {
    super.onInit();
  }

  Future<Response> download(url) => get(url);
}
