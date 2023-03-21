import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:app/app/data/data.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/home/providers/auth_provider.dart';

class ProfileController extends GetxController {
  final AuthProvider authProvider;
  ProfileController({
    required this.authProvider,
  });

  final presistentData = PresistentData();

  var isLoading = false.obs;


  final globalFormKey = GlobalKey<FormState>().obs;


  void setIsLoading(value) => isLoading.value = value;
  bool getIsLoading() => isLoading.value;



  final homeController = Get.find<HomeController>();

  String getFullName() {
    return Functions.fullname(homeController.getUser()?.firstname,
        homeController.getUser()?.lastname);
  }

  @override
  void onInit() {
    super.onInit();
  }

  void signOut() {
    setIsLoading(true);
    final FormData _formData = FormData({
      'fcm': null,
    });
    authProvider.setNotification(_formData).then((value) {
      setIsLoading(false);
      if (value.statusCode == 200) {
        print('success');
        presistentData.writeAuthToken('');
        Get.offNamedUntil('/login', ModalRoute.withName('toNewLogin'));
      }
    });
  }

 

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
