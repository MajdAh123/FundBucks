import 'package:app/app/modules/photo/providers/photo_provider.dart';
import 'package:app/app/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:get/get.dart';

class PhotoController extends GetxController {
  final PhotoProvider photoProvider;
  PhotoController({
    required this.photoProvider,
  });

  var photoUrl = ''.obs;

  void setPhotoUrl(url) => photoUrl.value = url;
  String getPhotoUrl() => photoUrl.value;

  @override
  void onInit() {
    setPhoto();
    super.onInit();
  }

  void setPhoto() {
    if (Get.arguments != null) {
      if (Get.arguments[0] != null) {
        setPhotoUrl(Get.arguments[0]);
      }
    }
  }

  void downloadImage() {
    Functions.downloadFile(getPhotoUrl());
  }

  // Future<void> downloadImage() async {
  //   final permission = await Functions.requestFilePermission();
  //   if (!permission) {
  //     print(permission);
  //     Get.showSnackbar(GetSnackBar(
  //       title: 'fail'.tr,
  //       message: 'must_accept_permission'.tr,
  //       duration: const Duration(seconds: defaultSnackbarDuration),
  //     ));
  //     return;
  //   }
  //   final checkAndroidVersion = await Functions.androidSdkAbove33();

  //   await ImageDownloader.downloadImage(
  //     getPhotoUrl(),
  //     // destination: AndroidDestinationType.,
  //     // destination: !checkAndroidVersion
  //     //     ? AndroidDestinationType.directoryDCIM
  //     //     : AndroidDestinationType.directoryDCIM
  //     //   ..inExternalFilesDir(),
  //   ).then((imageId) async {
  //     print(imageId);
  //     if (imageId == null) {
  //       Get.showSnackbar(GetSnackBar(
  //         title: 'fail'.tr,
  //         message: 'something_happened'.tr,
  //         duration: const Duration(seconds: defaultSnackbarDuration),
  //       ));
  //       return;
  //     }
  //     Get.showSnackbar(GetSnackBar(
  //       title: 'success'.tr,
  //       message: 'photo_saved'.tr,
  //       duration: const Duration(seconds: defaultSnackbarDuration),
  //     ));
  //     var path = await ImageDownloader.findPath(imageId);
  //     print(path);
  //     await ImageDownloader.open(path!);
  //   }).onError((error, StackTrace stackTrace) {
  //     print(error);
  //     print(stackTrace);
  //   });
  // }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
