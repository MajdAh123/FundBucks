import 'package:app/app/utils/utils.dart';
import 'package:get/get.dart';

import 'package:app/app/modules/gateway_detail/providers/gateway_provider.dart';

class GatewayDetailController extends GetxController {
  final GatewayProvider gatewayProvider;

  var isLoading = false.obs;

  var data = ''.obs;

  var id = 2.obs;

  void setId(value) => id.value = value;
  int getId() => id.value;

  void setIsLoading(bool value) => isLoading.value = value;
  bool getIsLoading() => isLoading.value;

  void setData(String data) => this.data.value = data;
  String getData() => data.value;

  GatewayDetailController({
    required this.gatewayProvider,
  });
  @override
  void onInit() {
    initArgs();
    getWireDetails();
    super.onInit();
  }

  void getWireDetails() {
    setIsLoading(true);
    gatewayProvider.getWireDetails(getId().toString()).then((value) {
      print(value.body);
      setIsLoading(false);
      if (value.statusCode == 200) {
        if (value.body['data'] != null) setData(value.body['data']);
      }
    });
  }

  void initArgs() {
    if (Get.arguments != null) {
      if (Get.arguments[0] != null) {
        setId(Get.arguments[0]);
      }
    }
  }

  Future<void> downloadPdf(url) async {
    Functions.downloadFile(url, true);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
